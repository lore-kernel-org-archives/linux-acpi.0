From: Kevin Fenzi <kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fn-keys on Compaq Evo n800v
Date: Fri, 28 Jan 2005 10:05:40 -0700
Message-ID: <20050128170543.E0767E7407@voldemort.scrye.com>
References: <1106904613.6133.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Anders" == Anders Persson <anders.persson-sT6loi8rTDSci/EUP2OQSw@public.gmane.org> writes:

Anders> I run Fedora Core 3 on a Compaq Evo n800v. After compiling a
Anders> new kernel (2.6.10) with a custom DSDT, ACPI seems to work
Anders> (almost) fine.  Processor, thermal-zones, lid-button, etc, all
Anders> seem ok.

Anders> However, the Fn+F7 & Fn+F8 key combinations for controlling
Anders> screen brightness stop working when X is started.

Anders> I have previously used exactly this custom DSDT without the
Anders> above problem on the same machine running RedHat 9 and a
Anders> 2.4.21 kernel.

Anders> Any input on how to solve this is much appreciated!

I have a presario 2800 (which is basically exactly the same as the evo
800).

In your xorg.conf in the Monitor device section, add: 

        Option      "AGPMode" "4"

(Even tho the video card in my case is a 1x agp I think). 

That causes my brightness keys to work fine again. 
You can also disable DRI and get the same effect, but then mission
critical apps like frozen-bubble or bzflag are slow. ;) 

Anders> /Anders

kevin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFB+nDn3imCezTjY0ERArUnAJ4m2vk45JpSTOfWY9Zk838DzQcJJQCeKVdK
rdYI/chAbs4BF+U3b04Sai4=
=uC+V
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
