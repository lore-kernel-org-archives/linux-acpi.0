From: Gabor FLEISCHER <swsusp-dated-1059009624.438966-XNofHPEhfVgNocND/f+tbZP2KDSNp7ea@public.gmane.org>
Subject: Re: Re: [Swsusp-devel] ACPI A/C adaptor status not updated
	upon resume
Date: Sat, 19 Jul 2003 03:20:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030719012023.GA26133@jcc.hu>
References: <F760B14C9561B941B89469F59BA3A847E9704C@orsmsx401.jf.intel.com>
	<20030718233847.GA18001@donkey.nsw.optushome.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030718233847.GA18001-dUyWl4+syqBVEeF2HbSC4pyo+8vLFsNxunOrhLTifxA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ka-shu Wong <kswong-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, EricAltendorf-gZ4DH+Stb0k@public.gmane.org, swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 19, 2003 at 09:38:47AM +1000, Ka-shu Wong <kswong-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org> wrote:
> There are two possible solutions that I can see:  Either make software
> suspend not restore the ACPI state, or reset the ACPI subsystem somehow
> after restore.
> 
> Are either of these solutions possible?

Yes, the second: if you compile AC as module, you can rmmod it before
suspend, and insmod it after suspend.

Gavriel


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
