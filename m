From: Francis Yom <fyom-NeBS1MF9zuBBDgjK7y7TUQ@public.gmane.org>
Subject: Anyone here with a Compaq Presario 2700 with memory overheating
 issues?
Date: 11 Nov 2002 01:26:41 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036996001.1459.9.camel@sera.symmetry.symmsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I am having some concerns with Compaq (now HP) with my Presario 2700.

I recently up'ed the memory to 1024 mb from 128 that came from the
factory.  I got the 2 x 512 mb sodimms from Crucial memory.

Since doing this, in an environment where the room temperature is above
70'F and if I don't prop the laptop feet, the screen will begin to
flicker after about 30 minutes of use.  

This flickering is the result of too much heat in the memory bay.  I
thought that ACPI has something to do with it (I'm using 20021101 patch)
but the processor and thermal zones come up fine. The fan kicks in fine
under high cpu loads.  But the screen still flickers.  The memory bay
gets VERY hot despite this....

Calling up Compaq and speaking to them, they are blaming the crucial
memory and telling me I should use Compaq branded memory only.  I think
this is B.S.  Then they told me that it's because I'm running linux and
that linux can't do ACPI (ha!).

I am wondering if anyone else here is using a 2700/2800 presario and has
screen flicker and a very hot memory bay.  Is there any truth to this
problem possibly being not compaq-branded memory?

I've confirmed my screen flicker is is from memory bay heat.  Putting a
nice cold can of soda on the memory bay access panel for a couple
seconds and then taking it off completely removes the flicker!

I have heard of 'laptop coolers' on the web, but I'm wondering if I can
get some kind of heat spreader for the sodimm memory chips.  Anybody can
help me here on this?

Many thanks!
Francis




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
