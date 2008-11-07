From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Fri, 7 Nov 2008 01:43:42 +0000
Message-ID: <20081107014342.GA9841@srcf.ucam.org>
References: <fa.UVpnVba3yRAWG3rGZ0sk20JE9hs@ifi.uio.no>
	<fa.FPBNKx3BSvZHPZ+eXD4Tb+fuRYk@ifi.uio.no>
	<fa.PvVEuEo+f/t4sLmcGyN2Tsl8zYg@ifi.uio.no>
	<fa.zzFdOXisTZzBaE1+ueGIYmt+Z5c@ifi.uio.no>
	<fa.vQ6HVRcPFFr1zpcXFFOjEPtDdNk@ifi.uio.no>
	<fa.ckUqcrtVKbxAkjNggIdajBTHr9Q@ifi.uio.no>
	<49139A43.4000203@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49139A43.4000203-fVOoFLC7IWo@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Robert Hancock <hancockr-fVOoFLC7IWo@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Eduardo Habkost <ehabkost-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhao Yakui <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 06, 2008 at 07:30:43PM -0600, Robert Hancock wrote:

> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8fd145917fb62368a9b80db59562c20576238f5a
> 
> This patch ignores the RESET_REG_SUP flag and just tries using the reset 
> register anyway if it thinks it's valid. So we may attempt ACPI reset on 
> machines which don't indicate it's supported.

Yeah, that sounds very wrong.

> The patch description mentioned that some machines didn't reboot after 
> S3 suspend without this patch. However, we recently had this patch merged:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a68823ee5285e65b51ceb96f8b13a5b4f99a6888
> 
> Is it possible that the problem fixed there is the true cause of this 
> reboot after S3 problem?

Oh, yeah, could be. Given the From:, I should really have thought of 
that :)

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
