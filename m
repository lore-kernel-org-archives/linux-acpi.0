From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 3/6] acpi : remove pointless cpuidle device state_count
	init
Date: Sun, 16 Sep 2012 23:02:55 +0200
Message-ID: <201209162302.55640.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
	<201209072350.50389.rjw@sisk.pl> <505638D9.80302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <505638D9.80302-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, September 16, 2012, Daniel Lezcano wrote:
> On 09/07/2012 11:50 PM, Rafael J. Wysocki wrote:
> > On Friday, September 07, 2012, Daniel Lezcano wrote:
> >> The cpuidle core takes care of filling this field from drv->state_count.
> > 
> > I'm not quite sure this is always valid.  If dev has already been
> > initialized and dev->state_count is different from 0,
> > cpuidle_enable_device() doesn't actually change it.
> > 
> > Have you considered all of the possible scenarios?
> 
> Ok, there is the scenario where the ACPI supports _CST.
> At runtime, ACPI may notify the OS a C-state changed for a specific cpu
> and this is done through 'acpi_processor_cst_has_changed' followed by
> 'acpi_processor_setup_cpuidle_cx'.
> 
> So at the end, we could have different cpus with one cpu with less
> C-states than the other, if I understood correctly ACPIspec30.pdf =>
> page 262 :)
> 
> In conclusion, we should keep this variable filled from there and keep
> this in mind in cpuidle.c in order to not break acpi in the future.
> Maybe a comment in cpuidle.c would help ... especially with a single
> C-state registration.

Sure, adding a comment in there sounds like a good idea.

Thanks,
Rafael
