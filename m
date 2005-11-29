From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: ACPI generic hotkey working on SONY (was: sony vaio pcg-k45 hell)
Date: Tue, 29 Nov 2005 22:48:15 +0100
Message-ID: <20051129214815.GA23455@message-id.s3e.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC212@pdsmsx403> <20051024102231.GA32705@message-id.gmane0305.slipkontur.de> <200510261029.01166.luming.yu@intel.com> <200511251602.02494.luming.yu@intel.com> <20051125120522.GA26643@message-id.s3e.de> <20051129153501.GB11822@message-id.s3e.de> <20051129204349.GA18378@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051129204349.GA18378-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 29, 2005 at 08:43:49PM +0000, Matthew Garrett wrote:
> On Tue, Nov 29, 2005 at 04:35:01PM +0100, Stefan Seyfried wrote:
> 
> > I have of course some other questions:
> > - what will happen on other machines if i load the hotkey module and issue
> >   echo "10001:1:1:0" >/proc/acpi/hotkey/action
> 
> To be honest, the generic hotkey driver seems to be something of a nasty 
> hack.

I won't argue against this. However, i stopped hoping to get all the drivers
i need included into the kernel, so i will concentrate on getting all 
machines working with the generic hotkey driver and include this support
in powersaved. Unfortunately, i am totally AML illiterate, so all i can
do is provide DSDTs and test any instructions given to me :-)

> It effectively exposes large parts of ACPI to userspace, but with 
> a very limited API and various artificial limitations. Is there any 
> reason why we don't shift to dev_acpi 
> (http://free.linux.hp.com/~awilliam/acpi/dev_acpi/) and have a userspace 
> application dealing with hotkey events? It would seem to be much more 
> flexible.

This would be fine with me also, i do not really care what i have to do to
get this hotkey events, as long as i can get them :-)
-- 
Stefan Seyfried


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
