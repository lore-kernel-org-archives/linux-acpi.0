From: Eric Altendorf <EricAltendorf-gZ4DH+Stb0k@public.gmane.org>
Subject: Re: [Swsusp-devel] ACPI A/C adaptor status not updated upon resume
Date: Thu, 17 Jul 2003 13:50:39 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307171350.39451.EricAltendorf@orst.edu>
References: <200307171306.47853.EricAltendorf@orst.edu> <1058473181.3298.28.camel@laptop-linux>
Reply-To: EricAltendorf-gZ4DH+Stb0k@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1058473181.3298.28.camel-udXHSmD1qAy4CTf7w+cZoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Fair enough -- I wasn't sure who was suppose to poll and who was 
supposed to notify......

Eric


On Thursday 17 July 2003 13:19, Nigel Cunningham wrote:
> That's ACPI, not swsusp - it must be toggling the state based on
> events, not actually detecting it.
>
> Regards,
>
> Nigel
>
> On Fri, 2003-07-18 at 08:06, Eric Altendorf wrote:
> > I'm still running an old version swsusp so I apologize if this
> > has already been addressed, but I figured I'd just make mention
> > of it.
> >
> > If the laptop is resumed with a different A/C adaptor state
> > (online vs. offline) than when it was suspended, the /proc entry
> > is incorrect upon resume.  E.g., plug laptop in, suspend, unplug
> > laptop, resume, /proc/acpi/ac_adapter/ADP1/state  reports still
> > online until a subsequent plug/unplug event.
> >
> > Eric
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: VM Ware
> > With VMware you can run multiple operating systems on a single
> > machine. WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual
> > machines at the same time. Free trial click here:
> > http://www.vmware.com/wl/offer/345/0
> > _______________________________________________
> > swsusp-devel mailing list
> > swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/swsusp-devel



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
