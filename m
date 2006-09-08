From: "Thomas W. Carley" <tcarley@embedded-zone.com>
Subject: Re: DSDT database
Date: Fri, 08 Sep 2006 14:37:32 -0400
Message-ID: <4501B86C.8010204@embedded-zone.com>
References: <D352FD896397D04482B87731BD4DBE7FD7C142@bjsmsx401>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([63.240.77.81]:19634 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750712AbWIHShm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Sep 2006 14:37:42 -0400
In-Reply-To: <D352FD896397D04482B87731BD4DBE7FD7C142@bjsmsx401>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ling L" <ling.l.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Never mind bundling them for me, I hacked up a little script to get them
all.

FYI, I used the following script to make a web page with links to all of
the DSDT files.

for ((i=0;i<=1000;i+=1));
do
	echo '<A href="http://acpi.sourceforge.net/dsdt/dl.php?id='$i'"> DSDT
'$i'</A>' >> links.html;
done

The I loaded links.html into firefox and used the down them all
extension to download all of the links. Some of them are not valid, and
result in files named "---custom.gz". Once these are erased I am left
with 652 files.

Yu, Ling L wrote:
>>> I am looking into the level of SMBus support in ACPI implementations.
> I
>>> see that the sourceforge project has 652 DSDT's in its database. I
> would
>>> like to run some automated scripts over these to get some statistics
>>> about the level of SMBus support. However, downloading them one at a
>>> time will take forever. Is the DSDT database available in whole? Can
>>> someone send me a link, or send the files directly?
>> Maybe Yu Ling knows how to get "behind the mirrors" of the web server
>> and can run something for you there?
> Thomas, 
> Do you really need all DSDTs on sourceforge web?
> If yes, I will try to export them and make a whole tarball, put
> somewhere to let you download.
> 
> Thanks
> - Ling
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFAbhsM+ThSqsPpFsRAv8kAKDfqaXFcJY+jiCPD0LXwRl3eqVZ+gCgoBet
dfEiIamd2Sp+fGZOLYyMCss=
=QHcE
-----END PGP SIGNATURE-----
