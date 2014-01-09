From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug for kexec
Date: Thu, 9 Jan 2014 10:00:53 -0500
Message-ID: <20140109150053.GD25897@redhat.com>
References: <1389220181-14474-1-git-send-email-prarit@redhat.com>
 <3476878.EqQiEtA2Ag@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3476878.EqQiEtA2Ag-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
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

On Thu, Jan 09, 2014 at 12:00:29AM +0100, Rafael J. Wysocki wrote:

[..]
> > The system then panics and the kdump/kexec kernel boots.  During this boot
> > ACPi is initialized and the kernel (as can be seen above)
> 
> Which is a bug.  You're not supposed to initialize ACPI twice in a row.

[CC lkml, kexec mailing list, dave young]

It is a fresh instance of kernel booting and it is initializing its data
structures fresh. It is *not* re-initializing ACPI in same kernel.

> > This patchset resolves the problem by adding a kernel parameter,
> > no_memory_hotplug, to disable ACPI memory hotplug.  It can be added by default
> > as a parameter to the kexec/kdump kernel so the kernel boots correctly.
> 
> This problem is specific to kexec/kdump, so please don't add *generic* command
> line parameters to address this.
> 

There are other command line options to solve kdump problems. In general
one might want to disable memory hogplug on the fly even if it is compiled
in the kernel. So it can act as a good debugging aid.

Secondly, it can be specified with memmap=exactmap and mem=X paramters to
make sure no memory is hot added in the system.

So I can see other usages of this parameter. To me it makes sense to have
a separate command line option to disable memory hotplug feature on the
fly.

Thanks
Vivek
