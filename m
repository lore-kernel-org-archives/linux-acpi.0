From: Ben Slusky <sluskyb-k/7z6JowIC0cuXOPmUuyGA@public.gmane.org>
Subject: Re: does cpu_idle() halt CPU?
Date: Fri, 11 Apr 2003 15:45:18 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030411194517.GA18029@fukurou.paranoiacs.org>
References: <F760B14C9561B941B89469F59BA3A847E96D94@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96D94-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 31 Mar 2003 10:15:01 -0800, Grover, Andrew wrote:
> > From: Jun Sun [mailto:jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org] 
> > This turns out to be key.  BTW, I did an experiement, usb-uhci has
> > the same effect too.
> 
> This is a bug.
> 
> I fixed the other uhci driver but didn't fix usb-uhci, a couple years
> ago. Basically, the HC should go into Global Suspend when no USB devices
> are connected to it, and wake up when one is connected.

The usb-ohci driver seems to have the same problem; my Libretto L1 won't
go into C3 when the module is loaded. I took a look at the driver but
of course it's very different from either of the uhci drivers, and way
over the head of a humble sysadmin such as myself... :-(

-- 
Ben Slusky                      | "Don't let it end like this.
sluskyb-8e/Pmov9ym4dnm+yROfE0A@public.gmane.org              |  Tell them I said something."
sluskyb-k/7z6JowIC0cuXOPmUuyGA@public.gmane.org          |               -last words of
PGP keyID ADA44B3B              |                Pancho Villa


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
