From: Praveen C <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
Subject: acpi on thinkpad r40e
Date: Fri, 6 Feb 2004 19:33:20 +0530 (IST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0402061913590.1089-100000@aero.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello all 
I am running linux 2.6.1 on thinkpad r40e with acpi 20040116.
Acpi partly works. I can get battery and ac adapter status. But thermal
and processor modules cause the system to hang and I have to then
poweroff. I cannot even connect from another computer when it hangs.

I am giving the url of some information below. Hope somebody will be 
able to tell me whats wrong.

I was looking at dsdt.dsl and noticed that some Name statements are 
located at the very end of the code. Is this wrong ? In my friends Acer 
I have seen that these statements come quite early in the dsl code.

All the files can be seen at
http://www.flatface.net/~praveen/tp/acpi

dmesg
http://www.flatface.net/~praveen/tp/acpi/dmesg.txt

lspci -vv
http://www.flatface.net/~praveen/tp/acpi/lspci.txt

lspnp -vv
http://www.flatface.net/~praveen/tp/acpi/lspnp.txt

dsdt.dsl
http://www.flatface.net/~praveen/tp/acpi/dsdt.dsl

dmidecode
http://www.flatface.net/~praveen/tp/acpi/dmidecode.txt

biosdecode
http://www.flatface.net/~praveen/tp/acpi/biosdecode.txt

Some hardware info obtained from hmonitor on windows
http://www.flatface.net/~praveen/tp/acpi/hmon2.txt

I really hope somebody can help me.
Thank you
praveen
-- 
------------------------------------------------------------------------------
Praveen. C
CFD Center, Dept. of Aerospace Engg.
IISc, Bangalore - 560012, India
Phone: +91-80-3600904
http://www.cpraveen.tk
http://aero.iisc.ernet.in/~praveen
------------------------------------------------------------------------------




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
