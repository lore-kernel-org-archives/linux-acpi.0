From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Via 694X based SMB boards (Apollo Pro133A)
Date: Thu, 15 Jan 2004 14:13:33 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040115141018.F72769@root.org>
References: <LAW11-OE34hRDT6Z3Ls000131c1@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <LAW11-OE34hRDT6Z3Ls000131c1-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 15 Jan 2004, Dino Klein wrote:
> I'm playing around with my Abit VP6 board - trying to get it into S3, and monkeying around with the Cx states.
> I'm having a problem figuring out how the Via VT82C686B chipset works with two processors, since a datasheet I found for it
> specifies only one P_BLK. Perhaps I have an older datasheet...
>
> Anyway, unless someone tells me that a the Apollo Pro133A chipset doesn't properly support SMP, I would like to ask other people out
> there who have 694X(DP) SMP board to take a look at their DSDT and send me the lines containing the processors definitions. If you
> don't know how to find it, just send me the whole thing, and I'll figure it out; maybe this way I'll figure out the address of the
> other P_BLK.

If you're looking to do throttling, some SMP boards support it.  The most
common way is with a shared P_BLK.  Either both Processor objects in the
ASL will have the same P_BLK or one will have it and the other will have a
NULL entry.  Either way, setting throttling through the P_BLK _ONCE_ (not
once per processor) sets the throttling level.

I've never seen an SMP board with separate P_BLKs per processor.  I've
also never seen an SMP board that supported C2 or higher via a shared
P_LVL2 register or separate _CST objects if it had different per-processor
P_LVL2 registers.  If anyone is aware of one of these, I'm very
interested.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
