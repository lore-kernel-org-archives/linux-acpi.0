From: Jacek Blizinski <azidog-SDTLKeebBdLQT0dZR+AlfA@public.gmane.org>
Subject: Please Help!
Date: Mon, 12 Jan 2004 19:52:35 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401121952.35240.azidog@nyc.rr.com>
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

Hello, I own a Fujitsu P5010D and I'm trying to fix my DSDT so that the volume 
controls work. The key mappings are as follows:

Fn+F3 = Mute
Fn+F4 = Disable/Enable Touchpad
Fn+F5 = Widescreen/Native Resolution
Fn+F6/7 = Brightness Down/UP
Fn+F8/9 = Volume down/up

The brightness controls work and all i wish to do is include the Mute and 
Volume up/down features. 

I have disassembled my dsdt:

Using iasl:
http://www.openjacek.org/dsdt/fujidsdt.dsl

Using acpidisasm:
http://www.openjacek.org/dsdt/dis_dsdt.dsl

I've tried to find guides online but have come up with anything. Any help 
would be greatly appreciated as this is a crucial feature for me and many 
others. Thank you in advance for your time.

--Jacek Blizinski


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
