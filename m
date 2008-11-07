From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Fri, 7 Nov 2008 00:59:46 +0000
Message-ID: <20081107005946.GA9254@srcf.ucam.org>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
	<200811061853.08003.arvidjaar@mail.ru>
	<alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
	<20081106215011.GA6391@srcf.ucam.org>
	<alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
	<1226019679.3989.107.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1226019679.3989.107.camel@yakui_zhao.sh.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Zhao Yakui <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Eduardo Habkost <ehabkost-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 07, 2008 at 09:01:19AM +0800, Zhao Yakui wrote:

> With the help of KVM I find that the windows will be rebooted by writing
> RESET_VALUE to RESET_REG I/O port if the RESET_REG_SUP bit is not
> zero(It indicates whether ACPI reboot is supported).
> IMO maybe the ACPI reboot is the first choice. If it can't, then it will
> fall back to other mode.

Hmm. But we're seeing some machines that end up very confused if 
rebooted via ACPI. I guess we need to run Vista on them to find out how 
they behave. What OSI strings did your KVM setup expose? We know that 
Windows changes behaviour under various circumstances depending on which 
OS the firmware requests, so it's almost possible that this is another 
of those cases.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
