From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Via 694X based SMB boards (Apollo Pro133A)
Date: Fri, 16 Jan 2004 19:19:35 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <LAW11-OE12KYXlz705N000297c0@hotmail.com>
References: <LAW11-OE34hRDT6Z3Ls000131c1@hotmail.com> <20040115141018.F72769@root.org> <Law11-OE71YaEv1Kq2E0000cace@hotmail.com> <20040115153450.J73140@root.org>
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

> What are your Processor objects?  Here's a dual processor Xeon board with
> a duplicated P_BLK.  The extra two objects are for the hyperthreading
> logical CPUs.
>
> IntelSE7501BR2.asl:        Processor (CPU1, 0x01, 0x00000410, 0x06) {}
> IntelSE7501BR2.asl:        Processor (CPU2, 0x02, 0x00000410, 0x06) {}
> IntelSE7501BR2.asl:        Processor (CPU3, 0x06, 0x00000410, 0x06) {}
> IntelSE7501BR2.asl:        Processor (CPU4, 0x07, 0x00000410, 0x06) {}

For my motherboard there is no P_BLK specified for either CPU.
However, what you show here makes me wonder about this:
******
4.7.3.5 Processor Register Block (P_BLK)
This optional register block is used to control each processor in the
system. There is one unique processor register block per processor in the
system.
******

This is from the 2.0c spec, which also appears in 1.0b.
Doesn't this imply that the statistics collected regarding the number of
state promotions/demotions are meanigless?
Perhaps I'm missing something, but that's how I understand it. Nevertheless,
I will give this scheme a try, just for the hell of it.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
