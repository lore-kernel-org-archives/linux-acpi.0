From: Matthew Keller <kellermg-aGob3lNJgTKVc3sceRu5cw@public.gmane.org>
Subject: Re: Re: does cpu_idle() halt CPU?
Date: 02 Apr 2003 16:42:51 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049319771.19172.27.camel@comp6161.potsdam.edu>
References: <F760B14C9561B941B89469F59BA3A847E96D88@orsmsx401.jf.intel.com>
	 <20030328150218.D10287@gateway.junsun.net>
	 <20030329134742.GD10287@poup.poupinou.org>
	 <m24r5hwfa5.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m24r5hwfa5.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


SGI's XFS is wonderful, AFAICT. Just make sure you have the latest tools
and whatnot.

On Wed, 2003-04-02 at 02:05, Jan Rychter wrote:
> >>>>> "DB" == Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>:
> [...]
>  DB> You forgot at least disk activities especially if ext3, which
>  DB> prevent almost all IDE drivers to go to idle state.  But that will
>  DB> not explain why you can not go to C3 though.
> 
> By the way, let me ask here: does anybody know what would be the best
> filesystem to use on a laptop, power saving being the #1 priority? Are
> all journaling filesystems this bad?
> 
> There was a project to teach the Linux kernel about drive spindown and
> manage drive accesses accordingly -- but last time I saw their docs they
> said that all journaling filesystems pose serious problems...
> 
> USB preventing the machine from going into C3 is a serious problem. I
> still don't understand if that's a hardware thing or can we have a more
> reasonable HCI implementation that doesn't use DMA that much. How does
> Windows deal with it?
> 
> --J.
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ValueWeb: 
> Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
> No other company gives more support or power for your dedicated server
> http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Matthew Keller
Enterprise Systems Analyst
Computing & Technology Services
State University of New York @ Potsdam
Potsdam, NY USA
http://mattwork.potsdam.edu/



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
