From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: Re: Intel Centrino and Linux
Date: 07 May 2003 13:02:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052308970.3061.4.camel@dhcp22.swansea.linux.org.uk>
References: <200305031848.04583.nbellm@gmx.de>
	 <1051979022.24562.24.camel@dhcp22.swansea.linux.org.uk>
	 <m21xzb9vig.fsf_-_@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m21xzb9vig.fsf_-_-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mer, 2003-05-07 at 06:27, Jan Rychter wrote:
> I'm facing this kind of decision (buying a new laptop soon, possibly the
> Toshiba DynaBook SS S7/290LNKW) -- so, does the above mean that Intel
> Centrino is not Linux friendly?

Currently yes. On some of them the APM works well enough to suspend and
do battery reporting but not to do CPU speed control stuff (at least not
from battery life measurement).

> I've already ruled out all Compaq notebooks thanks to the multiple
> problem reports seen on this list (hi HP/Compaq! 

The newer Compaq ACPI seems to work well (eg the z9xx series laptops).
They do need an ACPI kernel and have some other quirks which needed
Linux fixing (and which showed up Linux bugs too)




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
