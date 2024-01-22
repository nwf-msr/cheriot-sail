/*
 * CHERIoT does not support virtual memory.  Stub out the types and functions
 * needed by the RISC-V model.
 */

/*
 * It is by far simplest if `satp` exists in the model, sadly.  But we can at
 * least avoid hooking it up to anything other than the CSR machinery.
 *
 * See sail-riscv/model/riscv_insts_zicsr.sail .  The legalize_satp{32,64}
 * functions of sail-riscv/model/riscv_sys_regs.sail are not used, as
 * the CHERIoT model does not include sail-riscv/model/riscv_vmem_rv{32,64}.sail
 */
register satp : xlenbits
function legalize_satp(a : Architecture, o : bits(32), v : bits(32)) -> bits(32) = v

/*
 * Copied from sail-riscv/model/riscv_vmem_common.sail .  The constructors of
 * this type are directly referenced throughout the RISC-V and CHERIoT models,
 * which also presume that its type variables are instantiated in particular
 * ways (see translateAddr, below).
 */
union TR_Result('paddr : Type, 'failure : Type) = {
  TR_Address : ('paddr, unit),
  TR_Failure : ('failure, unit)
}

/* The entrypoint to VMEM; on CHERIoT, THIS is always the identity map. */
val translateAddr : (xlenbits, AccessType(ext_access_type)) -> TR_Result(xlenbits, ExceptionType)
function translateAddr(vAddr, ac) = TR_Address(vAddr, ())

/* Stub initializer for a stub VMEM subsystem */
function init_vmem () -> unit = ()

/*
 * The base RISC-V model also presumes the existence of a TLB to flush.  Stub
 * that out rather than supplanting the entirety of
 * sail-riscv/model/riscv_insts_base.sail
 */
function flush_TLB (_: option(xlenbits), _: option(xlenbits)) -> unit = ()
