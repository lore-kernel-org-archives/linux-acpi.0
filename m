From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Via 694X based SMB boards (Apollo Pro133A)
Date: Thu, 15 Jan 2004 17:36:28 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Law11-OE71YaEv1Kq2E0000cace@hotmail.com>
References: <LAW11-OE34hRDT6Z3Ls000131c1@hotmail.com> <20040115141018.F72769@root.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> If you're looking to do throttling, some SMP boards support it.  The most
> common way is with a shared P_BLK.  Either both Processor objects in the
> ASL will have the same P_BLK or one will have it and the other will have a
> NULL entry.  Either way, setting throttling through the P_BLK _ONCE_ (not
> once per processor) sets the throttling level.


Actually, I did play with the throttling, but not through the ACPI driver. I wrote directly to the register, and the system was
reduced to  ~5% (according to the datasheets) of it's former glory. I did that with both CPUs on the board, which makes me wonder -
is there some way to figure out what is the clock speed of a particular CPU? maybe this way I can figure out whether my actions
operate on both CPUs or only one one.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
