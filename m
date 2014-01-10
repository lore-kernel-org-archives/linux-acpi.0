From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug for kexec
Date: Fri, 10 Jan 2014 09:38:46 -0500
Message-ID: <20140110143846.GA19115@redhat.com>
References: <1389220181-14474-1-git-send-email-prarit@redhat.com>
 <3476878.EqQiEtA2Ag@vostro.rjw.lan>
 <20140109150053.GD25897@redhat.com>
 <2117213.k9zFiTsMXU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2117213.k9zFiTsMXU-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kexec Mailing List <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux kernel mailing list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 10, 2014 at 02:31:31AM +0100, Rafael J. Wysocki wrote:

[..]
> > It is a fresh instance of kernel booting and it is initializing its data
> > structures fresh. It is *not* re-initializing ACPI in same kernel.
> 
> I know.  The problem is that the BIOS is generally not stateless and it
> remebers stuff.  In particular, there are a few handshakes done during the ACPI
> initialization and they cannot be repeated without resetting the BIOS to the
> initial state, which basically means a reboot.

Agreed that stateless BIOS in general would be a problem with kexec. We
already face that issue with UEFI where we can't call set virtual address
map again in second kernel and kexec did not work with UEFI for so many
years. Thanks to Dave, Borislav and Matt that it will soon be working and
we will be passing mappings to second kernel.

So even in case of ACPI, if there are things which can't be re-initiliazed
in second kernel, we will have to figure that out and selectively fix it
by passing that info to second kernel and not ask second kernel to
reinitialize it, instead of disabling ACPI completely.

> 
> That is kind of orthogonal to the problem at hand, though.

Agreed.

Thanks
Vivek
