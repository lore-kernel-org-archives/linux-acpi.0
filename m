From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Sat, 1 Jan 2005 20:36:01 -0800 (PST)
Message-ID: <20050102043601.63276.qmail@web50202.mail.yahoo.com>
References: <20050101175715.GA1345@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050101175715.GA1345-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

I don't have swsusp compiled in, but if I unload and
reload the module, then it works.
Anyway, this is not the intended behaviour, as it
worked fine till 2.6.10 without unload/reload.

Thanks,
Paul

--- Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Hi!
> 
> > With kernel 2.6.10, I have the following problem
> with uhci_hcd:
> > After an ACPI S3 suspend it fails to see any USB
> device plugged in.
> > If I unload the module and load it again, it works
> again.
> > I hadn't this problem with previous kernels, where
> it worked just fine.
> > Do you know something that changed between 2.6.9
> and 2.6.10 that could
> > lead to this behavior ?
> > It is ACPI or USB fault ?
> 
> Does it work after swsusp? Can you try unloading
> module before suspend
> and reloading it after resume?
> 								Pavel
> -- 
> People were complaining that M$ turns users into
> beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb
> yvxr vg gung jnl!
> 



		
__________________________________ 
Do you Yahoo!? 
Send a seasonal email greeting and help others. Do good. 
http://celebrity.mail.yahoo.com


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
