From: Rob Lee <rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v4 1/4] cpuidle: Add time keeping and irq enabling
Date: Mon, 6 Feb 2012 11:14:55 -0600
Message-ID: <CAMXH7KG4bfH=tbLmniZZVegyphY_p8q27NAtoo5PHjUCG+ULRg@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
	<1328065215-28108-2-git-send-email-rob.lee@linaro.org>
	<CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Baohua.Song-kQvG35nSl+M@public.gmane.org, linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello Colin, thanks for the review.

On Sat, Feb 4, 2012 at 1:02 PM, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, Jan 31, 2012 at 7:00 PM, Robert Lee <rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Make necessary changes to add implement time keepign and irq enabling
> keeping
>> in the core cpuidle code. =A0This will allow the remove of these
>> functionalities from the platform cpuidle implementations.
>>
>> Signed-off-by: Robert Lee <rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> =A0drivers/cpuidle/cpuidle.c | =A0 75 ++++++++++++++++++++++++++++++++++=
+---------
>> =A0include/linux/cpuidle.h =A0 | =A0 26 ++++++++++-----
>> =A02 files changed, 76 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 59f4261..8ea0fc3 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -57,14 +57,18 @@ static int __cpuidle_register_device(struct cpuidle_=
device *dev);
>> =A0* cpuidle_idle_call - the main idle loop
>> =A0*
>> =A0* NOTE: no locks or semaphores should be used here
>> + * NOTE: Should only be called from a local irq disabled context
>> =A0* return non-zero on failure
>> + *
>> =A0*/
>> =A0int cpuidle_idle_call(void)
>> =A0{
>> =A0 =A0 =A0 =A0struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_de=
vices);
>> =A0 =A0 =A0 =A0struct cpuidle_driver *drv =3D cpuidle_get_driver();
>> =A0 =A0 =A0 =A0struct cpuidle_state *target_state;
>> - =A0 =A0 =A0 int next_state, entered_state;
>> + =A0 =A0 =A0 int idx, ret =3D 0;
>> + =A0 =A0 =A0 ktime_t t1, t2;
>> + =A0 =A0 =A0 s64 diff;
>>
>> =A0 =A0 =A0 =A0if (off)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> @@ -86,37 +90,76 @@ int cpuidle_idle_call(void)
>> =A0#endif
>>
>> =A0 =A0 =A0 =A0/* ask the governor for the next state */
>> - =A0 =A0 =A0 next_state =3D cpuidle_curr_governor->select(drv, dev);
>> + =A0 =A0 =A0 idx =3D cpuidle_curr_governor->select(drv, dev);
>> +
>> + =A0 =A0 =A0 target_state =3D &drv->states[idx];
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Check with the device to see if it can enter this sta=
te or if another
>> + =A0 =A0 =A0 =A0* state should be used.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (target_state->pre_enter) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D target_state->
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pre_enter(dev, drv, idx);
> Unnecessary line wrap and braces.

Thanks.

>
> What's the point of the pre_enter call? =A0This seems very similar to
> the prepare call that was removed in 3.2. =A0Drivers can already demote
> the target state in their enter call. =A0The only thing you do between
> pre_enter and enter is trace and account for the time. =A0Is there some
> long call you don't want included in the idle time? =A0Some
> documentation would help, and you need to very clearly define the
> semantics of when post_enter gets called when pre_enter or enter
> return errors.

pre_enter's purpose is to perform any necessary platform technology
that can be performed before entering that actual idle or some
restricted idle context where only platform specific code can run.  If
I try to consolidate the timekeeping in the core cpuidle driver
without pre_enter, then my idle time will incorrectly account for this
platform preparation time.  Perhaps this small idle time accounting
error isn't of concern to anyone though.

The previous version of this patch submission used a different
approach by adding a wrapper that could be used by fairly simple
cpuidle implementations.  In the v3 submission of this patch series,
Daniel asked about the possibility of just performing this
consolidation in the cpuidle_idle_call function itself.  Instead of
debating the pros and cons of it, I thought it might be better to send
this version of the patch and discuss it further.

Another approach I thought about may be to add flags that indicate
whether or not the platform or the core driver should perform the time
keeping.  Or, go back to the wrapper function approach.  Please feel
free to give your opinion on the preferred approach.

Agree on the documentation.  I was trying to just get this patch
series out there for discussion before spending more time on it in
case it is not the desired approach to timekeeping and irq disabling
consolidation.
