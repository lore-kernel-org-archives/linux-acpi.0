From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Re: Suspend-to-RAM on ThinkPad R51
Date: Thu, 31 Mar 2005 10:44:34 -0500
Message-ID: <200503311044.35221.barr.156@osu.edu>
References: <200503261534.44710.barr.156@osu.edu> <200503301136.59046.barr.156@osu.edu> <20050330202416.GA1347@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050330202416.GA1347-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 30 March 2005 03:24 pm, Pavel Machek wrote:
> Well, non-working video is common problem after suspend-to-ram, see
> Documentation/power/video.txt.

I have confirmed that input is not a problem. I can sleep and resume and then 
ssh into my laptop and do a 'cat /dev/input/mice'. Moving my finger on the 
touchpad generates output. Same for typing on the keyboard and doing a 
'cat /dev/input/event0'.

Now the question is: if my display wakes up--i.e. the backlight comes on and 
the contents on the screen right before suspend are displayed--do I have a 
video problem that I should be pursuing as such? Many of the ACPI video 
sleeping bugs on bugme.osdl.org have a completely dead display--i.e. no 
backlight.

Andrew


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
