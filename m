From: Eric Altendorf <EricAltendorf-gZ4DH+Stb0k@public.gmane.org>
Subject: Re: Re: [Swsusp-devel] ACPI A/C adaptor status not =?iso-8859-1?q?updated	upon?= resume
Date: Sun, 20 Jul 2003 19:31:21 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307201931.21741.EricAltendorf@orst.edu>
References: <F760B14C9561B941B89469F59BA3A8470255EE9D@orsmsx401.jf.intel.com> <20030719041325.GA18250@donkey.nsw.optushome.com.au> <1058590455.2598.6.camel@laptop-linux>
Reply-To: EricAltendorf-gZ4DH+Stb0k@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1058590455.2598.6.camel-udXHSmD1qAy4CTf7w+cZoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 18 July 2003 21:54, Nigel Cunningham wrote:
> Hi.
>
> Yes, swsusp will be storing the ACPI state (along with all the rest
> of memory). Swsusp has no way to tell whether the state is invalid
> or not, or to exclude arbitrary parts of the memory from the image
> (particularly since we're probably not talking about a whole page
> here). The easiest way to overcome this problem at the moment is to
> make sure the state is the same when you resume as it is when you
> suspend. Failing that, a DSDT override that does the right thing.
> Does unplugging and plugging in the power post resume get the BIOS
> to set things right?

Yes, but only if the post is live, which generally isn't the case when 
this problem pops up. :-)

Eric


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
