From: Johnathan Hicks <thetech-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: An embedded-Linux power-management framework
Date: Fri, 02 Aug 2002 20:48:15 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D4B284F.20402@folkwolf.net>
References: <20020802172802.GA32612@avalon.paulsen.org> 	<1028315477.18635.113.camel@irongate.swansea.linux.org.uk> 	<1028312475.23390.63.camel@granite.austin.ibm.com> <1028330951.31733.5.camel@irongate.swansea.linux.org.uk>
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
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Alan Cox wrote:
> On Fri, 2002-08-02 at 19:20, Hollis Blanchard wrote:
> 
>>There are situations (especially in dedicated-purpose devices running
>>only a few hand-written applications) in which it helps to change some
>>of these values without changing the others. Changing them all according
>>to a single variable (CPU core frequency) could be very limiting. To my
>>knowledge the cpufreq code also does not allow for this flexibility, but
>>certainly it would be nice to add it.
> 
> 
> So improve the cpufreq code to be a bit more controllable. Its the right
> framework. It also needs a littlw tweaking for the cases where we change
> STPCLK on x86's.

Are you sure that cpufreq should be tweaked to manage STPCLK? Would it not 
make more sence to suck cpufreq into ACPI and call it during Tx (throttling) 
states if applicable? Of course I realise that might not be allowed by the 
ACPI spec, but some combination of cqufreq and the Tx states is a good idea... 
and optional for the user.

--John

--John




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
