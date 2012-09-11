From: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: CONFIG_NO_HZ + CONFIG_CPU_IDLE freeze the system (Was Re: [PATCH]
	acpi : remove power from acpi_processor_cx structure)
Date: Tue, 11 Sep 2012 10:26:05 -0700
Message-ID: <504F742D.6000701@linaro.org>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org>
	<201209062204.11288.rjw@sisk.pl> <50490920.9070204@linaro.org>
	<201209062318.42874.rjw@sisk.pl> <504A02BD.4000805@linaro.org>
	<504A2D73.3010702@linaro.org> <504A68A0.7010907@linaro.org>
	<504E1FE5.6090502@linaro.org> <504E4343.5070004@linaro.org>
	<504E8372.20904@linaro.org> <504EE124.3010401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <504EE124.3010401-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, xen-devel-GuqFBffKawuULHF6PoxzQEEOCMrvLtNR@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 09/10/2012 11:58 PM, Daniel Lezcano wrote:
>> Would you mind testing the following patch? It seems to resolve the
>> issue, but I've not yet run it through my test suite to make sure it
>> didn't break anything else.
> No problem, I will try it this evening.
>
> Is this problem related to all 32bits arch ?
I believe so. Although it didn't appear in my 32bit testing w/ kvm, but 
I suspect that is due to my distro userland setting lots of timers so 
that we don't hit those multi-second idle times, which could overflow 
32bit nanoseconds, or maybe some other kvm quirk.

Anyway, let me know if your testing goes well.

Thanks so much again for noticing and bisecting this down.
-john
