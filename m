From: Vince Herried <vherried-rEckef8uG3NTGrOy2lmfZw@public.gmane.org>
Subject: acpi functionality?
Date: Sun, 21 Dec 2003 21:56:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312212156.21261.vherried@insight.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dell Lattitude C810 running RedHat 9...

this laptop has a Fn key and several functions with holding Fn and then 
pressing another key.  Under acpi they don't seem to work (not in linux or 
w2k).

I hardly ever run Win 2k and didn't notice it till recently.
I assume this is a dell bug?  and will likely never be fixed.

stuff like

Fn Z 	-	shuts off the fans (which come on when resuming from a suspend even if 
the box is cold).

Fn D	-	turns off the display.  Hum, this would be nice to have working.
	either my bios setting or RedHat shut the display off while I was building a 
nother try at 2.6.0  and I couldn't get it to turn back on.   Sigh.  

Fn and function keys to go to setup, display battery charge ....


I'm guessing I'm gonna have to disable acpi b4 these are gonna work, right?

v



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
