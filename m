From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Wrong temperature and battery status when running on
 battery (bug 3678)
Date: Fri, 7 Jan 2005 12:22:24 +0000
Message-ID: <16862.32512.874723.4759@aber.ac.uk>
References: <16861.5954.584694.204594@aber.ac.uk>
	<Pine.LNX.4.60.0501071144470.1259@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0501071144470.1259-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org writes:
 > -----BEGIN PGP SIGNED MESSAGE-----
 > Hash: SHA1
 > 
 > Salut Fred,
 > On Thu, 6 Jan 2005, Fred Labrosse wrote:
 > > <http://bugme.osdl.org/show_bug.cgi?id=3678>.  Basically, it seems that
 > > ACPI dies (wrong temperature and battery status and machine does not power
 > > off anymore) shortly after doing:
 > >
 > > echo -n powersave > /sys/devices/sys/cpu0/cpufreq/scaling_governor
 > >
 > > This is on an ACER TM636 and started happening since 2.6.7 (included).
 > > Could people having a similar hardware try that to see if it's just me?
 > I am currently running 2.6.10-vanilla, on a TM634. But I am sorry, that I 
 > cannot reproduce eighter of your findings. To be precise, the file on my 
 > system ist located a bit different:
 > echo -n powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

My mistake.  You are right.

I will try with 2.6.10 asap.

It happens to me between 1min and 1hour following the change in scaling
governor.  Did you wait a bit?

Cheers,

Fred



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
