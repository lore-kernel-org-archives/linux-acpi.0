From: "Thomas Renninger" <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [suse-laptop] Re: acpi related problem on ACER TM 4002WLMi running SuSE 9.2
Date: Mon, 21 Mar 2005 23:31:09 +0100
Message-ID: <000201c52e65$ae1cba20$0173a8c0@karschnet.local>
References: <d49121bb05031414506df19df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <d49121bb05031414506df19df-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: skarsch-EZnA+GhA2Xev1Vk0o9suBQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, suse-laptop-IBi9RG/b67k@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Carlos E Manglano-Villamarin wrote:
> Hi everyone,
> 
> my problem is that I cannot manage to have the battery icon showing
> when running 'kpowersave' in the pannel. Only the icon for AC mode
> appears, and the computer thinks it's running under AC :-/
> 
> I've tried to download and install some patch from this site but I
> have a serious doubt before messing around with the kernel. Let's go
> step-by-step:
> 
> 1) I dowloaded the 'sbs-cm-20050213' patch, extracted it and followed
> the instructions
> 2) But when I get to step 8 and go to the webpage recommended 
> http://forums.gentoo.org/viewtopic.php?t=122145
> I read the following line
> "SuSE 9.0 already includes this patch in the default kernel! See
> /etc/sysconfig/kernel for more information (ACPI_DSDT=...)"
> 
> I don't know if I should follow all the steps or try a different
> approach to my problem.
> 
> Any help, plz?
> 

I think you are referring to this manual from
https://sourceforge.net/projects/sbs-linux/:


1) Ensure that you have the source tree installed for your kernel. If
   you are going to be using the embedded controller spinlock patch
   (discussed further below), you will probably have to use the
   2.6.10 kernel.

2) Change into the directory containing the patches (i.e., the same
   directory in which you found this README file).

3) Ensure that you have Intel's iasl compiler installed somewhere in
   your PATH. The compiler can be downloaded from:
        http://developer.intel.com/technology/iapc/acpi/downloads.htm
   It appears that older versions of the compiler (e.g., 20040715)
   produce incorrect code; therefore, make sure your version is a
   relatively-recent one (e.g., 20041203).

4) [As root] Grab a copy of your current DSDT:
        cat /proc/acpi/dsdt > dsdt.dat

5) Disassemble the DSDT, to produce the file dsdt.dsl:
        iasl -d dsdt.dat

6) Patch the dsdt.dsl file with the appropriate patch (see the table above):
        patch < XXXXXXXX-sbs-cm.diff

7) Recompile the DSDT, to produce the file DSDT.aml:
        iasl dsdt.dsl

8) [As root] Follow the instructions for installing the new DSDT
   (DSDT.aml) given on this page:
        http://forums.gentoo.org/viewtopic.php?t=122145
   Section 9 gives the appropriate instructions; there are 3 different
   methods of installing the DSDT, I find method 9b (initrd DSDT
   override) to be the easiest. Whichever method you chose, however,
   you *will* have to recompile and reinstall your kernel at least
   once.

9) [As root] Install the embedded controller spinlock patch, that I
   describe below in the "Embedded Controller Patch" section. This
   step is optional, but pretty important if you don't want to get
   missed keypresses and other weirdness.

10) Reboot your machine. Your battery(s) should now show up in
   /proc/acpi/battery, and your AC adapter in /proc/acpi/ac_adapter

________________________________--

Running SUSE you do not need to recompile your kernel:

Skip 1 and be sure you have the pmtools package installed (should be default AFAIK).

Follow step 2-6

7) Recompile the DSDT, to produce the file DSDT.aml:
        iasl -sa dsdt.dsl

8a) copy the compiled DSDT.aml file e.g. to /etc

8b) add the path pointing to e.g. /etc/DSDT.aml to /etc/sysconfig/kernel
    ACPI_DSDT="/etc/DSDT.aml"

8c) Append DSDT to initrd:
    mkinitrd

8d) reboot

9) If you encounter problems of too high CPU load because battery is
   polled too often, set POWERSAVED_FORCE_BATTERY_POLLING="no"
   in (depends on your version, is it SL 9.2?) in /etc/sysconfig/powersave/battery

   In this case the battery is only polled on battery events (if battery info
   is updated too seldom, switch it on again).
   If it still does not help you need to compile the kernel and add the patch
   as described above (9), but then better ask again and I can tell you
   how you get your original SUSE kernel configs.


Tell me if you encounter problems or if it works.

Good luck,

      Thomas

P.S.: You might want to subscribe the suse-laptop list if you have other
laptop specific problems:
http://www.suse.com/en/private/support/online_help/mailinglists/

-- 
Um die Liste abzubestellen, schicken Sie eine Mail an:
    suse-laptop-unsubscribe-IBi9RG/b67k@public.gmane.org
Um eine Liste aller verfuegbaren Kommandos zu bekommen, schicken
Sie eine Mail an: suse-laptop-help-IBi9RG/b67k@public.gmane.org






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
