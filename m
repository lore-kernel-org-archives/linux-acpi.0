From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] ACPI: fix vendor-defined resource infinite loops
Date: Wed, 2 Nov 2005 09:26:35 -0700
Message-ID: <200511020926.35548.bjorn.helgaas@hp.com>
References: <971FCB6690CD0E4898387DBF7552B90E0336A3EE@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E0336A3EE-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 27 October 2005 12:38 pm, Moore, Robert wrote:
> These loops go away with the recent release of ACPI CA (20051021) --
> replaced by a memcpy, so this problem should be solved.
> 
> You may want to verify this with the new code; I can send you the source
> code package if you need it.
> 
> With this update, I have defined and deployed new types to deal with
> resource sizes -- a length type for the 16-bit resource length field,
> and a 32-bit type for the maximum resource descriptor length which is
> (64k -1) + 3.

Ping...  Len, what are your plans here?  Will the 20051021 ACPICA show
up in -mm soon?  If not, would you mind dropping in either my patch
or the relevant bit from the CA?

I'd like to get some sort of fix in ASAP, because we're testing boxes
that have large vendor-defined resources, and this bug makes them
hang.

> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Bjorn Helgaas
> > Sent: Wednesday, October 26, 2005 3:18 PM
> > To: Brown, Len
> > Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Matthew Wilcox
> > Subject: [ACPI] [PATCH] ACPI: fix vendor-defined resource infinite
> loops
> > 
> > Loop index type not large enough to represent loop termination value
> ==>
> > badness.  I've tripped over the first infinite loop and verified that
> > this patch fixes it.  The second problem was found by inspection.
> > 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
