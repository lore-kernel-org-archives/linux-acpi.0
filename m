From: Lin Ming <minggr@gmail.com>
Subject: Re: [PATCH 3/3] ACPICA: Fix code divergence of global lock handling
Date: Fri, 25 Mar 2011 11:07:49 +0800
Message-ID: <AANLkTi=sO80QNBSiQzCuHgANi+Ug58bHP1L7=gnL9d3i@mail.gmail.com>
References: <1300872396-16522-1-git-send-email-ming.m.lin@intel.com>
	<1300872396-16522-4-git-send-email-ming.m.lin@intel.com>
	<201103232133.58523.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48292 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab1CYDHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Mar 2011 23:07:49 -0400
Received: by iyb14 with SMTP id 14so60050iyb.19
        for <linux-acpi@vger.kernel.org>; Thu, 24 Mar 2011 20:07:49 -0700 (PDT)
In-Reply-To: <201103232133.58523.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

2011/3/24 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday, March 23, 2011, Lin Ming wrote:
>> Commit 9cd0314(ACPI / ACPICA: Fix global lock acquisition) was backp=
orted
>> into ACPICA code base, and some divergence was introduced.
>>
>> This patch fixed it,
>> - rename acpi_ev_global_lock_pending/acpi_ev_global_lock_pending_loc=
k
>> =A0 to acpi_gbl_global_lock_pending/acpi_gbl_global_lock_pending_loc=
k.
>>
>> - move the initialization of acpi_gbl_global_lock_pending_lock from
>> =A0 acpi_ut_mutex_initialize to acpi_ev_init_global_lock_handler.
>>
>> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

Len,

Could you consider applying these patches for 2.6.39-rc1?

Thanks,
Lin Ming

>
>> ---
>> =A0drivers/acpi/acpica/acglobal.h | =A0 =A06 ++-
>> =A0drivers/acpi/acpica/evmisc.c =A0 | =A0 74 +++++++++++++++++++++--=
----------------
>> =A0drivers/acpi/acpica/utmutex.c =A0| =A0 =A05 ---
>> =A03 files changed, 44 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/ac=
global.h
>> index 6d512fc..73863d8 100644
>> --- a/drivers/acpi/acpica/acglobal.h
>> +++ b/drivers/acpi/acpica/acglobal.h
>> @@ -214,13 +214,16 @@ ACPI_EXTERN struct acpi_mutex_info acpi_gbl_mu=
tex_info[ACPI_NUM_MUTEX];
>>
>> =A0/*
>> =A0 * Global lock mutex is an actual AML mutex object
>> - * Global lock semaphore works in conjunction with the HW global lo=
ck
>> + * Global lock semaphore works in conjunction with the actual globa=
l lock
>> + * Global lock spinlock is used for "pending" handshake
>> =A0 */
>> =A0ACPI_EXTERN union acpi_operand_object *acpi_gbl_global_lock_mutex=
;
>> =A0ACPI_EXTERN acpi_semaphore acpi_gbl_global_lock_semaphore;
>> +ACPI_EXTERN acpi_spinlock acpi_gbl_global_lock_pending_lock;
>> =A0ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
>> =A0ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
>> =A0ACPI_EXTERN u8 acpi_gbl_global_lock_present;
>> +ACPI_EXTERN u8 acpi_gbl_global_lock_pending;
>>
>> =A0/*
>> =A0 * Spinlocks are used for interfaces that can be possibly called =
at
>> @@ -228,7 +231,6 @@ ACPI_EXTERN u8 acpi_gbl_global_lock_present;
>> =A0 */
>> =A0ACPI_EXTERN acpi_spinlock acpi_gbl_gpe_lock; /* For GPE data stru=
cts and registers */
>> =A0ACPI_EXTERN acpi_spinlock acpi_gbl_hardware_lock; =A0 =A0/* For A=
CPI H/W except GPE registers */
>> -ACPI_EXTERN acpi_spinlock acpi_ev_global_lock_pending_lock; /* For =
global lock */
>>
>> =A0/****************************************************************=
*************
>> =A0 *
>> diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmi=
sc.c
>> index 7dc8094..69a3b4a 100644
>> --- a/drivers/acpi/acpica/evmisc.c
>> +++ b/drivers/acpi/acpica/evmisc.c
>> @@ -284,39 +284,41 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_d=
ispatch(void *context)
>> =A0 * RETURN: =A0 =A0 =A0ACPI_INTERRUPT_HANDLED
>> =A0 *
>> =A0 * DESCRIPTION: Invoked directly from the SCI handler when a glob=
al lock
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0release interrupt occurs. =A0If there=
's a thread waiting for
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0the global lock, signal it.
>> - *
>> - * NOTE: Assumes that the semaphore can be signaled from interrupt =
level. If
>> - * this is not possible for some reason, a separate thread will hav=
e to be
>> - * scheduled to do this.
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0release interrupt occurs. If there is=
 actually a pending
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0request for the lock, signal the wait=
ing thread.
>> =A0 *
>> =A0 ****************************************************************=
**************/
>> -static u8 acpi_ev_global_lock_pending;
>>
>> =A0static u32 acpi_ev_global_lock_handler(void *context)
>> =A0{
>> =A0 =A0 =A0 acpi_status status;
>> =A0 =A0 =A0 acpi_cpu_flags flags;
>>
>> - =A0 =A0 flags =3D acpi_os_acquire_lock(acpi_ev_global_lock_pending=
_lock);
>> + =A0 =A0 flags =3D acpi_os_acquire_lock(acpi_gbl_global_lock_pendin=
g_lock);
>>
>> - =A0 =A0 if (!acpi_ev_global_lock_pending) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If a request for the global lock is not actually pend=
ing,
>> + =A0 =A0 =A0* we are done. This handles "spurious" global lock inte=
rrupts
>> + =A0 =A0 =A0* which are possible (and have been seen) with bad BIOS=
s.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (!acpi_gbl_global_lock_pending) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto cleanup_and_exit;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /* Send a unit to the semaphore */
>> -
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Send a unit to the global lock semaphore. The actual =
acquisition
>> + =A0 =A0 =A0* of the global lock will be performed by the waiting t=
hread.
>> + =A0 =A0 =A0*/
>> =A0 =A0 =A0 status =3D acpi_os_signal_semaphore(acpi_gbl_global_lock=
_semaphore, 1);
>> =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_ERROR((AE_INFO, "Could not signal G=
lobal Lock semaphore"));
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 acpi_ev_global_lock_pending =3D FALSE;
>> + =A0 =A0 acpi_gbl_global_lock_pending =3D FALSE;
>>
>> - out:
>> - =A0 =A0 acpi_os_release_lock(acpi_ev_global_lock_pending_lock, fla=
gs);
>> +cleanup_and_exit:
>>
>> + =A0 =A0 acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, fl=
ags);
>> =A0 =A0 =A0 return (ACPI_INTERRUPT_HANDLED);
>> =A0}
>>
>> @@ -350,14 +352,20 @@ acpi_status acpi_ev_init_global_lock_handler(v=
oid)
>> =A0 =A0 =A0 =A0* Map to AE_OK, but mark global lock as not present. =
Any attempt to
>> =A0 =A0 =A0 =A0* actually use the global lock will be flagged with a=
n error.
>> =A0 =A0 =A0 =A0*/
>> + =A0 =A0 acpi_gbl_global_lock_present =3D FALSE;
>> =A0 =A0 =A0 if (status =3D=3D AE_NO_HARDWARE_RESPONSE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_ERROR((AE_INFO,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "No response fro=
m Global Lock hardware, disabling lock"));
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 acpi_gbl_global_lock_present =3D FALSE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(AE_OK);
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 status =3D acpi_os_create_lock(&acpi_gbl_global_lock_pendi=
ng_lock);
>> + =A0 =A0 if (ACPI_FAILURE(status)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(status);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 acpi_gbl_global_lock_pending =3D FALSE;
>> =A0 =A0 =A0 acpi_gbl_global_lock_present =3D TRUE;
>> =A0 =A0 =A0 return_ACPI_STATUS(status);
>> =A0}
>> @@ -414,7 +422,7 @@ static int acpi_ev_global_lock_acquired;
>> =A0acpi_status acpi_ev_acquire_global_lock(u16 timeout)
>> =A0{
>> =A0 =A0 =A0 acpi_cpu_flags flags;
>> - =A0 =A0 acpi_status status =3D AE_OK;
>> + =A0 =A0 acpi_status status;
>> =A0 =A0 =A0 u8 acquired =3D FALSE;
>>
>> =A0 =A0 =A0 ACPI_FUNCTION_TRACE(ev_acquire_global_lock);
>> @@ -458,15 +466,15 @@ acpi_status acpi_ev_acquire_global_lock(u16 ti=
meout)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> - =A0 =A0 =A0* Make sure that a global lock actually exists. If not,=
 just treat the
>> - =A0 =A0 =A0* lock as a standard mutex.
>> + =A0 =A0 =A0* Make sure that a global lock actually exists. If not,=
 just
>> + =A0 =A0 =A0* treat the lock as a standard mutex.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (!acpi_gbl_global_lock_present) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_gbl_global_lock_acquired =3D TRUE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(AE_OK);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 flags =3D acpi_os_acquire_lock(acpi_ev_global_lock_pending=
_lock);
>> + =A0 =A0 flags =3D acpi_os_acquire_lock(acpi_gbl_global_lock_pendin=
g_lock);
>>
>> =A0 =A0 =A0 do {
>>
>> @@ -475,20 +483,19 @@ acpi_status acpi_ev_acquire_global_lock(u16 ti=
meout)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, =
acquired);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acquired) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_gbl_global_lock_acq=
uired =3D TRUE;
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_DEBUG_PRINT((ACPI_D=
B_EXEC,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 "Acquired hardware Global Lock\n"));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 acpi_ev_global_lock_pending =3D TRUE;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 acpi_os_release_lock(acpi_ev_global_lock_p=
ending_lock, flags);
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* Did not get the lock. The pending bit=
 was set above, and we
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* must wait until we get the global loc=
k released interrupt.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Did not get the lock. The pending bit=
 was set above, and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* we must now wait until we receive the=
 global lock
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* released interrupt.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 acpi_gbl_global_lock_pending =3D TRUE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 acpi_os_release_lock(acpi_gbl_global_lock_=
pending_lock, flags);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Wai=
ting for hardware Global Lock\n"));
>>
>> @@ -496,17 +503,16 @@ acpi_status acpi_ev_acquire_global_lock(u16 ti=
meout)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Wait for handshake with the global =
lock interrupt handler.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This interface releases the interpr=
eter if we must wait.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_ex_system_wait_semaphore(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 acpi_gbl_global_lock_semaphore,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ACPI_WAIT_FOREVER);
>> + =A0 =A0 =A0 =A0 =A0 =A0 status =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_ex_system_wait_semaphore
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (acpi_gbl_global_lock_semaphore, A=
CPI_WAIT_FOREVER);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags =3D acpi_os_acquire_lock(acpi_ev_glo=
bal_lock_pending_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 flags =3D acpi_os_acquire_lock(acpi_gbl_gl=
obal_lock_pending_lock);
>>
>> =A0 =A0 =A0 } while (ACPI_SUCCESS(status));
>>
>> - =A0 =A0 acpi_ev_global_lock_pending =3D FALSE;
>> -
>> - =A0 =A0 acpi_os_release_lock(acpi_ev_global_lock_pending_lock, fla=
gs);
>> + =A0 =A0 acpi_gbl_global_lock_pending =3D FALSE;
>> + =A0 =A0 acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, fl=
ags);
>>
>> =A0 =A0 =A0 return_ACPI_STATUS(status);
>> =A0}
>> diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utm=
utex.c
>> index 519d4ee..7d797e2 100644
>> --- a/drivers/acpi/acpica/utmutex.c
>> +++ b/drivers/acpi/acpica/utmutex.c
>> @@ -93,11 +93,6 @@ acpi_status acpi_ut_mutex_initialize(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS (status);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 status =3D acpi_os_create_lock (&acpi_ev_global_lock_pendi=
ng_lock);
>> - =A0 =A0 if (ACPI_FAILURE (status)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS (status);
>> - =A0 =A0 }
>> -
>> =A0 =A0 =A0 /* Mutex for _OSI support */
>> =A0 =A0 =A0 status =3D acpi_os_create_mutex(&acpi_gbl_osi_mutex);
>> =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
