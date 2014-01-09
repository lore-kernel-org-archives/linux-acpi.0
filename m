From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
Date: Thu, 9 Jan 2014 13:23:10 -0500
Message-ID: <20140109182310.GG25897@redhat.com>
References: <52CD6E33.400@redhat.com> <20140108155829.GC13649@redhat.com>
 <8500545.JVNPnKcyD1@vostro.rjw.lan>
 <1389226308.1792.39.camel@misato.fc.hp.com>
 <20140109145035.GB25897@redhat.com>
 <1389283439.1792.66.camel@misato.fc.hp.com>
 <20140109162427.GF25897@redhat.com>
 <1389288265.1792.108.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389288265.1792.108.camel-RbGIw1UOYPVo/CpIj0byZw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>
Cc: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tangchen-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhangyanfei-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 09, 2014 at 10:24:25AM -0700, Toshi Kani wrote:

[..]
> > I think creating a new command line option is simpler as compared to
> > creating a new flag in bootparam which in turn disables memory hotplug.
> > More users can use that option. For example, if for some reason hotplug
> > code is crashing, one can just disable it on command line as work around
> > and move on.
> 
> I do not have a strong opinion about having such option.  However, I
> think it is more user friendly to keep the exactmap option works alone
> on any platforms.

I think we should create internally a variable which will disable memory
hotplug. And set that variable based on memmap=exactmap, mem=X and also
provide a way to disable memory hotplug directly using command line
option.

Current kexec-tools can use memmap=exactmap and be happy. I am writing
a new kexec syscall and will not be using memmap=exactmap and would need
to use that command line option to disable memory hotplug behavior.

Thanks
Vivek
