From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: An embedded-Linux power-management framework
Date: 03 Aug 2002 14:47:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028382470.31718.43.camel@irongate.swansea.linux.org.uk>
References: <20020802172802.GA32612@avalon.paulsen.org>
	<1028315477.18635.113.camel@irongate.swansea.linux.org.uk>
	<1028312475.23390.63.camel@granite.austin.ibm.com>
	<1028330951.31733.5.camel@irongate.swansea.linux.org.uk>
	<3D4B284F.20402@folkwolf.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D4B284F.20402-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Johnathan Hicks <thetech-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2002-08-03 at 01:48, Johnathan Hicks wrote:
> Are you sure that cpufreq should be tweaked to manage STPCLK? Would it not 
> make more sence to suck cpufreq into ACPI and call it during Tx (throttling) 
> states if applicable? Of course I realise that might not be allowed by the 
> ACPI spec, but some combination of cqufreq and the Tx states is a good idea... 
> and optional for the user.

It may make sense on a box with ACPI, but most boxes that are heavily
STPCLK managed are older. The Athlon one seems to be less interesting
than the others (btw - seems you can mix stpclk with the other features
you just have to turn stpclk back off before idling)

On a K5/K6/486/.. STPCLK is basically your entire power management
barring what lurks on the PCI devices - which can save a suprising
amount of power too. I've been playing (not very successfully at the
moment) at dropping my video card into D3 when screenblanking




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
