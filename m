From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Kernel Oops when loading battery module
Date: 08 Dec 2002 12:07:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039367266.1416.3.camel@sirius.strandboge.cxm>
References: <20021207003056.GC8072@homerelay.wiesner-net.de>
	 <1039229157.2913.5.camel@sirius.strandboge.cxm>
	 <20021207142228.GA20455@homerelay.wiesner-net.de>
	 <1039273263.2913.23.camel@sirius.strandboge.cxm>
	 <20021208132229.GB21604@homerelay.wiesner-net.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-j6X56/tiedGNNLHsy66Y"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021208132229.GB21604-aCYJ90g6FbN3mO1V46hDx7oZL2q1Rlic@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-j6X56/tiedGNNLHsy66Y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-12-08 at 08:22, Markus Wiesner wrote:
> James D Strandboge schrieb:
> > Could you send me your script (off list)?  My script sounds like it does
> > the same thing, but I would get this strange hang.
> 
> Sure. But it's really very simple. In fact only a set of shortcuts for
> "cat /proc/acpi/[...]" :-)
> 
> An idea would be to redirect output to /dev/console and then execute the
> script with a single key combination and view its output in xconsole.
> 
> > Could you also send me your dsdt so I can compare it to mine?
> 
> You mean /proc/acpi/dsdt? Ok, attached that, too.
> 

Well, I recompiled with 20020829 and 2.4.20-pre5-- still have the same
problem.  Can you run the attached script with your working
configuration and let me know if your laptop locks up?  Feel free to go
in single user mode-- I don't need X or anything running to get the
lockup.

Jamie

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A


--=-j6X56/tiedGNNLHsy66Y
Content-Disposition: attachment; filename=acpi_test.sh
Content-Type: text/x-sh; name=acpi_test.sh; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/sh

let i=0

while [ /bin/true ]
do
	let i=i+1

	REMAIN=`grep remain /proc/acpi/battery/BAT1/state | awk '{ print $3 }'`
	if [ $REMAIN -lt 0 ]
	then
		echo "problem"
		exit 1
	fi
	echo "$i: $REMAIN remaining"
done
exit 0;


--=-j6X56/tiedGNNLHsy66Y--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
