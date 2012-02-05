From: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH v4 1/4] cpuidle: Add time keeping and irq enabling
Date: Sat, 4 Feb 2012 17:48:28 -0800
Message-ID: <CAJOA=zMp-bydL8tJuY_xUOFFNk3EBrvUDOoW+gcYB_-WLRu6sQ@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
	<1328065215-28108-2-git-send-email-rob.lee@linaro.org>
	<CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg@mail.gmail.com>
	<CAJOA=zOhKtt5GohHfYp6=xVTODR2a_RGkDNTwozbusrBSsqE+w@mail.gmail.com>
	<CAMbhsRR2Zsv7d+_iganMhz5WxDiUYd-zOCoVehz4yjzyH2q+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAMbhsRR2Zsv7d+_iganMhz5WxDiUYd-zOCoVehz4yjzyH2q+wA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Baohua.Song-kQvG35nSl+M@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Feb 4, 2012 at 5:36 PM, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> On Sat, Feb 4, 2012 at 2:06 PM, Turquette, Mike <mturquette-l0cyMroinI0@public.gmane.org> wrote:
>> On Sat, Feb 4, 2012 at 11:02 AM, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>>> What's the point of the pre_enter call? =A0This seems very similar to
>>> the prepare call that was removed in 3.2. =A0Drivers can already demote
>>
>> Hi Colin,
>>
>> I asked Rob to re-introduce the .prepare callback (not .pre_enter).
>>
>> The short version of why I requested this is so that I can experiment
>> with modifying wake-up latency and theshold values dynamically based
>> on PM QoS constraints. =A0For an OMAP-specific example, I'd like to see
>> our C-states no longer model both MPU and CORE power domains, and
>> instead only model the MPU. =A0Then when entering idle the PM QoS
>> constraints against the CORE power domain's wake-up latency can be
>> considered in the .prepare callback which will affect the C-state
>> parameters as well as program the CORE low power target state.
>
> prepare makes sense to adjust latencies, as long as it is not used for
> state demotion as well.

Latency adjustment is the plan.  State demotion is not.

Rob,

If you cook up another version of this series feel free to drop
.pre_enter.  It would be nice if you re-introduced .prepare as per our
original discussion but if that's a roadblock then you can forget that
point too and I'll take a crack at it later.

Regards,
Mike

>> .pre_enter isn't really right for the above case so I'm happy for it
>> to be dropped, but I'll probably re-introduce something like .prepare
>> in the future...
>>
>> Regards,
>> Mike
>>
>>> the target state in their enter call. =A0The only thing you do between
>>> pre_enter and enter is trace and account for the time. =A0Is there some
>>> long call you don't want included in the idle time? =A0Some
>>> documentation would help, and you need to very clearly define the
>>> semantics of when post_enter gets called when pre_enter or enter
>>> return errors.
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
