From: Ari Pollak <ajp-vB92YU/q1whiLUuM0BA3LQ@public.gmane.org>
Subject: Re: Status of ACPI on IBM T40p
Date: Fri, 06 Feb 2004 19:35:50 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <c01bt1$tj7$1@sea.gmane.org>
References: <200402041507.33902@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402041507.33902-qgpBcDF1kIxsXm07kNcISIFwBlHcXKVlHZ5vskTnxNA@public.gmane.org>
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

Interesting, I have the exact opposite problem. According to the power 
states:

active state:            C2
default state:           C1
bus master activity:     02000008
states:
     C1:                  promotion[C2] demotion[--] latency[000] 
usage[00000010]
*C2:                  promotion[C3] demotion[C1] latency[001] 
usage[01048795]
C3:                  promotion[--] demotion[C2] latency[085] usage[01977750]

As you can see, my Thinkpad T41 rarely goes higher than C2, even when a 
program is using 100% or compiling or something along those lines.


> The CPU has C0-C3. C0 is full speed, the rest is slower. According to the ACPI 
> documentation the CPU should switch automagically to the slower modes after 
> some time of inactivaty. However it cannot controll busmaster PCI transfers 
> in C3. Now some driver doesn't gets busmaster right, and due to this, the cpu 
> never go's to C3 [Hope I got this right, I am no acpi master..](my went to C3 
> after some fiddeling with suspend (see later) and the PCI-Bus crashed, hence 
> I know. If my CPU uses C3, laptop_mode and backlight  mostly dimmed, I 
> reached 5h+ :)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
