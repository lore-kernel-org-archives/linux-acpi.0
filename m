From: =?ISO-8859-1?Q?S=E9rgio_Montei?=ro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Re: ACPI & APIC
Date: Wed, 16 Oct 2002 17:27:25 +0100 (WEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034785645.3dad936d0b9f2@webmail.sapo.pt>
References: <20021014105058.7898C2063B@mail.uboot.com> <1034711544.1511.2.camel@speedy-gonzales> <3DAD2270.A97616D7@monetplus.cz> <200210160913.43931@-mixdown.ca>
Reply-To: Sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200210160913.43931-T9p8nP5vHr8sA/PxXw9srA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Kohlsmith <akohlsmith-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Citando Andrew Kohlsmith <akohlsmith-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>:

 
} You're saying that if you compile the kernel WITHOUT
} APIC support that you 
} don't need pci=noacpi?  This is a valuable clue I
} think!  I think I'm going 
} to try that in the next day or so and see if it's the
} same here.
} 
} Maybe the Compaq laptops have bad entries for the
} APIC initialization in the 
} ACPI tables or something.

I Have one compaq pressario 706EA.
even without ACPI pacthes, I have problems with boot and reboot,
if APIC is enabled.
The first time that I had install red hat 7.2 on my laptop,
sometimes give me oops, I after many kernel installations I
discovered that the problem is with APIC enabled.
I had try kernel 2.5.x and I had same problem.

Btw: as anyone know who or where is develop APIC for kernel 2.4?


Sérgio Monteiro Basto
		

--------------------------------------------
SAPO ADSL.PT Agora o kit apenas por 75 Eur. e tráfego ilimitado até ao final de 2002!
Mais informações em http://www.sapo.pt/kitadsl


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
