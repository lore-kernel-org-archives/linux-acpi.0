From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: RE: Presario DANGER
Date: Thu, 7 Nov 2002 18:13:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021107171346.GB157@elf.ucw.cz>
References: <200211041130.44371.ruud.koendering@planet.nl> <1036414528.1113.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1036414528.1113.8.camel-MMxVpc8zpTQVh3rx8e9g/fyykp6/JSeS3vcXtXqGYxw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: ruud koendering <ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > All the Compaq Presario's are in danger without ACPI. This is confirmed by new 
> > HP. (They d'ont feel to be responcible as always in certain companies. Make 
> > something, sell it and then so0rry c'ant help you)
> 
> That means you cannot even run DOS on that laptop or any software which
> disables interrupts for a long time thus stopping ACPI running. It also
> means it is not a PC compatible system. So its not even safe to boot
> your old PC games on, not even Doom
> 
> I'm under the impression ACPI requires proper thermal protection
> too.

Its there:

When the heat reaches the temperature indicated by _CRT, the OS must
immediately shutdown the system.
The system must disable the power either after the temperature reaches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
some hardware-determined level above
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_CRT or after a predetermined time has passed. Before disabling power,
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
platform designers should incorporate
some time that allows the OS to run its critical shutdown
operation. There is no requirement for a minimum
shutdown operation window that commences immediately after the
temperature reaches _CRT.  This is
because
*  Heat might rise rapidly in some systems and slower on others,
depending on casing design and
    environmental factors.
*  Shutdown can take several minutes on a server and only a few short
seconds on a hand-held device.
Because of this indistinct discrepancy and the fact that a critical
heat situation is a remarkably rare occurrence,
ACPI does not specify a target window for a safe shutdown. It is
entirely up to the OEM to build in a safe
buffer that it sees fit for the target platform.


								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
