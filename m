From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] Xen/ACPI: support sleep state
 entering on hardware reduced systems
Date: Mon, 11 Mar 2013 09:21:27 -0400
Message-ID: <20130311132127.GH23018@phenom.dumpdata.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <tboot-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <513DB68E02000078000C4864@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=tboot-devel>
List-Post: <mailto:tboot-devel@lists.sourceforge.net>
List-Help: <mailto:tboot-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: tboot-devel-bounces@lists.sourceforge.net
To: Jan Beulich <JBeulich@suse.com>, rjw@sisk.pl
Cc: xen-devel <xen-devel@lists.xen.org>, linux-acpi@vger.kernel.org, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 11, 2013 at 09:48:46AM +0000, Jan Beulich wrote:
> In version 3.4 acpi_os_prepare_sleep() got introduced in parallel with
> reduced hardware sleep support, and the two changes didn't get
> synchronized: The new code doesn't call the hook function (if so
> requested). Fix this, requiring a boolean parameter to be added to the
> hook function to distinguish "extended" from "legacy" sleep.

Ooops.
> 
> This requires adjusting TXT, but the adjustments only go as far as
> failing the extended mode call (since, looking at the TXT interface,
> there doesn't even appear to be precautions to deal with that
> alternative interface).
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Richard L Maliszewski <richard.l.maliszewski@intel.com>

CC: Rafael since he is the ACPI maintainer nowadays. Len
is concentrating on Intel-Idle.

> Cc: Gang Wei <gang.wei@intel.com>
> Cc: Shane Wang <shane.wang@intel.com>
> 
> ---
>  arch/x86/kernel/tboot.c          |    6 +++++-
>  drivers/acpi/acpica/hwesleep.c   |    8 ++++++++
>  drivers/acpi/acpica/hwsleep.c    |    2 +-
>  drivers/acpi/osl.c               |   16 ++++++++--------
>  drivers/xen/acpi.c               |   26 +++++++++++++-------------
>  include/linux/acpi.h             |   10 +++++-----
>  include/xen/acpi.h               |    4 ++--
>  include/xen/interface/platform.h |    7 ++++---
>  8 files changed, 46 insertions(+), 33 deletions(-)
> 
> --- 3.9-rc2/arch/x86/kernel/tboot.c
> +++ 3.9-rc2-xen-ACPI-v5-sleep/arch/x86/kernel/tboot.c
> @@ -273,7 +273,8 @@ static void tboot_copy_fadt(const struct
>  		offsetof(struct acpi_table_facs, firmware_waking_vector);
>  }
>  
> -static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
> +static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,
> +		       bool extended)
>  {
>  	static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] = {
>  		/* S0,1,2: */ -1, -1, -1,
> @@ -284,6 +285,9 @@ static int tboot_sleep(u8 sleep_state, u
>  	if (!tboot_enabled())
>  		return 0;
>  
> +	if (extended)
> +		return -1;
> +
>  	tboot_copy_fadt(&acpi_gbl_FADT);
>  	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control;
>  	tboot->acpi_sinfo.pm1b_cnt_val = pm1b_control;
> --- 3.9-rc2/drivers/acpi/acpica/hwesleep.c
> +++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/acpi/acpica/hwesleep.c
> @@ -43,6 +43,7 @@
>   */
>  
>  #include <acpi/acpi.h>
> +#include <linux/acpi.h>
>  #include "accommon.h"
>  
>  #define _COMPONENT          ACPI_HARDWARE
> @@ -128,6 +129,13 @@ acpi_status acpi_hw_extended_sleep(u8 sl
>  
>  	ACPI_FLUSH_CPU_CACHE();
>  
> +	status = acpi_os_prepare_sleep(sleep_state, acpi_gbl_sleep_type_a,
> +				       acpi_gbl_sleep_type_b, true);
> +	if (ACPI_SKIP(status))
> +		return_ACPI_STATUS(AE_OK);
> +	if (ACPI_FAILURE(status))
> +		return_ACPI_STATUS(status);
> +
>  	/*
>  	 * Set the SLP_TYP and SLP_EN bits.
>  	 *
> --- 3.9-rc2/drivers/acpi/acpica/hwsleep.c
> +++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/acpi/acpica/hwsleep.c
> @@ -153,7 +153,7 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>  	ACPI_FLUSH_CPU_CACHE();
>  
>  	status = acpi_os_prepare_sleep(sleep_state, pm1a_control,
> -				       pm1b_control);
> +				       pm1b_control, false);
>  	if (ACPI_SKIP(status))
>  		return_ACPI_STATUS(AE_OK);
>  	if (ACPI_FAILURE(status))
> --- 3.9-rc2/drivers/acpi/osl.c
> +++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/acpi/osl.c
> @@ -77,8 +77,8 @@ EXPORT_SYMBOL(acpi_in_debugger);
>  extern char line_buf[80];
>  #endif				/*ENABLE_DEBUGGER */
>  
> -static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 pm1a_ctrl,
> -				      u32 pm1b_ctrl);
> +static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 val_a, u32 val_b,
> +				      bool extended);
>  
>  static acpi_osd_handler acpi_irq_handler;
>  static void *acpi_irq_context;
> @@ -1757,13 +1757,13 @@ acpi_status acpi_os_terminate(void)
>  	return AE_OK;
>  }
>  
> -acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
> -				  u32 pm1b_control)
> +acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 val_a, u32 val_b,
> +				  bool extended)
>  {
>  	int rc = 0;
>  	if (__acpi_os_prepare_sleep)
> -		rc = __acpi_os_prepare_sleep(sleep_state,
> -					     pm1a_control, pm1b_control);
> +		rc = __acpi_os_prepare_sleep(sleep_state, val_a, val_b,
> +					     extended);
>  	if (rc < 0)
>  		return AE_ERROR;
>  	else if (rc > 0)
> @@ -1772,8 +1772,8 @@ acpi_status acpi_os_prepare_sleep(u8 sle
>  	return AE_OK;
>  }
>  
> -void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
> -			       u32 pm1a_ctrl, u32 pm1b_ctrl))
> +void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state, u32 val_a,
> +					   u32 val_b, bool extended))
>  {
>  	__acpi_os_prepare_sleep = func;
>  }
> --- 3.9-rc2/drivers/xen/acpi.c
> +++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/xen/acpi.c
> @@ -35,27 +35,27 @@
>  #include <asm/xen/hypercall.h>
>  #include <asm/xen/hypervisor.h>
>  
> -int xen_acpi_notify_hypervisor_state(u8 sleep_state,
> -				     u32 pm1a_cnt, u32 pm1b_cnt)
> +int xen_acpi_notify_hypervisor_state(u8 sleep_state, u32 val_a, u32 val_b,
> +				     bool extended)
>  {
> +	unsigned int bits = extended ? 8 : 16;
> +
>  	struct xen_platform_op op = {
>  		.cmd = XENPF_enter_acpi_sleep,
>  		.interface_version = XENPF_INTERFACE_VERSION,
> -		.u = {
> -			.enter_acpi_sleep = {
> -				.pm1a_cnt_val = (u16)pm1a_cnt,
> -				.pm1b_cnt_val = (u16)pm1b_cnt,
> -				.sleep_state = sleep_state,
> -			},
> +		.u.enter_acpi_sleep = {
> +			.val_a = (u16)val_a,
> +			.val_b = (u16)val_b,
> +			.sleep_state = sleep_state,
> +			.flags = extended ? XENPF_ACPI_SLEEP_EXTENDED : 0,
>  		},
>  	};
>  
> -	if ((pm1a_cnt & 0xffff0000) || (pm1b_cnt & 0xffff0000)) {
> -		WARN(1, "Using more than 16bits of PM1A/B 0x%x/0x%x!"
> -		     "Email xen-devel@lists.xensource.com  Thank you.\n", \
> -		     pm1a_cnt, pm1b_cnt);
> +	if (WARN((val_a & (~0 << bits)) || (val_b & (~0 << bits)),
> +		 "Using more than %u bits of sleep control values %#x/%#x!"
> +		 "Email xen-devel@lists.xen.org - Thank you.\n", \
> +		 bits, val_a, val_b))
>  		return -1;
> -	}
>  
>  	HYPERVISOR_dom0_op(&op);
>  	return 1;
> --- 3.9-rc2/include/linux/acpi.h
> +++ 3.9-rc2-xen-ACPI-v5-sleep/include/linux/acpi.h
> @@ -486,11 +486,11 @@ static inline bool acpi_driver_match_dev
>  #endif	/* !CONFIG_ACPI */
>  
>  #ifdef CONFIG_ACPI
> -void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
> -			       u32 pm1a_ctrl,  u32 pm1b_ctrl));
> +void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state, u32 val_a,
> +					   u32 val_b, bool extended));
>  
> -acpi_status acpi_os_prepare_sleep(u8 sleep_state,
> -				  u32 pm1a_control, u32 pm1b_control);
> +acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 val_a, u32 val_b,
> +				  bool extended);
>  #ifdef CONFIG_X86
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else
> @@ -500,7 +500,7 @@ static inline void arch_reserve_mem_area
>  }
>  #endif /* CONFIG_X86 */
>  #else
> -#define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
> +#define acpi_os_set_prepare_sleep(func, val_a, val_b, ext) do { } while (0)
>  #endif
>  
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM_RUNTIME)
> --- 3.9-rc2/include/xen/acpi.h
> +++ 3.9-rc2-xen-ACPI-v5-sleep/include/xen/acpi.h
> @@ -75,8 +75,8 @@ static inline int xen_acpi_get_pxm(acpi_
>  	return -ENXIO;
>  }
>  
> -int xen_acpi_notify_hypervisor_state(u8 sleep_state,
> -				     u32 pm1a_cnt, u32 pm1b_cnd);
> +int xen_acpi_notify_hypervisor_state(u8 sleep_state, u32 val_a, u32 val_b,
> +				     bool extended);
>  
>  static inline void xen_acpi_sleep_register(void)
>  {
> --- 3.9-rc2/include/xen/interface/platform.h
> +++ 3.9-rc2-xen-ACPI-v5-sleep/include/xen/interface/platform.h
> @@ -152,10 +152,11 @@ DEFINE_GUEST_HANDLE_STRUCT(xenpf_firmwar
>  #define XENPF_enter_acpi_sleep    51
>  struct xenpf_enter_acpi_sleep {
>  	/* IN variables */
> -	uint16_t pm1a_cnt_val;      /* PM1a control value. */
> -	uint16_t pm1b_cnt_val;      /* PM1b control value. */
> +	uint16_t val_a;             /* PM1a control / sleep type A. */
> +	uint16_t val_b;             /* PM1b control / sleep type B. */
>  	uint32_t sleep_state;       /* Which state to enter (Sn). */
> -	uint32_t flags;             /* Must be zero. */
> +#define XENPF_ACPI_SLEEP_EXTENDED 0x00000001
> +	uint32_t flags;             /* XENPF_ACPI_SLEEP_*. */

Could the commit should also mention what version of the Xen hypervisor
supports this new flag and takes action on it?


Besides that little nit-pick it looks OK to me. Are there any changes
neccessary on the IA64 or ARM side for this?

>  };
>  DEFINE_GUEST_HANDLE_STRUCT(xenpf_enter_acpi_sleep_t);
>  
> 
> 

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
