From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: 2.6.25-rc2-mm1 (x64 thermal build failure)
Date: Tue, 19 Feb 2008 09:41:47 -0800
Message-ID: <20080219094147.b9e0e99b.randy.dunlap@oracle.com>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
	<20080216211603.bb4f3582.randy.dunlap@oracle.com>
	<20080216214410.b9699910.akpm@linux-foundation.org>
	<20080218111536.511c4fbc@crazy>
	<20080218041340.f1e46ec9.akpm@linux-foundation.org>
	<20080219165502.2c202759@crazy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:44845 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbYBSRmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2008 12:42:17 -0500
In-Reply-To: <20080219165502.2c202759@crazy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, michael@free-electrons.com

On Tue, 19 Feb 2008 16:55:02 +0100 Thomas Petazzoni wrote:

> Le Mon, 18 Feb 2008 04:13:40 -0800,
> Andrew Morton <akpm@linux-foundation.org> a =E9crit :
>=20
> > Option 3 wold be to add more #ifdef CONFIG_DMI lines around the
> > place.  How ugly would that get?
>=20
> Like the attached patch. #ifdef CONFIG_DMI everywhere :-(


Does this patch apply to -mm?  Seem like No.

After converting it from mime(?) to ASCII and fixing one #if
(change "and" to "&&") & fixing patch rejects, it does build cleanly.


---
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
