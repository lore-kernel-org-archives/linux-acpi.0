From: =?ISO-8859-1?Q?Robert_W=F6rle?= <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Tablet PC + 2.4.18 + acpi 20020726 + swsup11 working !
Date: Tue, 06 Aug 2002 09:30:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D4F7B2A.2090602@symplon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi Folks

Im a smurf reader of this list and i ve been trying ACPI now for more 
than 5 months .
The device i want to have ACPI running is the worlds first Tablet PC 
called  "Pacebook" .
As i am pretty much the only linux enthusiastic at our company , im 
"porting " linux to that Tablet .

Until now ACPI was quite good working : I can read the battery state , 
see if im plugged or not , get the temperatur of the TRANSMETA (!) and 
all that minor stuff , BUT i had no chance to use S3 S4 ---until 
yesterday when i tried the mentioned patches and now can S4 very good !!
--YES it is working ! __ icantbelievethat _

So guys : I congratulate you ! Very very very good work !

Things TODO now :
try to get S3 also working ( to have this , ive to implement a function 
to turn off the backlight )
i ve the spec`s and I/O Port to do that  ,but im still expierencing 
problems at starting to write this driver , since
a device called pic2 is loaded at the needed I/O Port  ( 0xB1-0xB2) ...

When i ve finished that driver ive to find a way , where the ACPI 
Subsystem can call that backlight_off function.

What is the supposed procedure to implement such "thirdparty" functions 
into ACPI ?
will there be a script to be called ( like at APM , where we had 
apmd_proxy to shutdown critical things before suspend ) ?


Anyhow folks ... im very proud of that community and keep up doing that 
great work !

Regards Rob
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
