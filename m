From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: asus_acpi, support F2JE model
Date: Wed, 11 Apr 2007 23:17:36 +0200
Message-ID: <461D5070.7080902@gmail.com>
References: <2189310342910921713@karneval.cz>	<20070411132053.899462b4.akpm@linux-foundation.org>	<461D45CE.3030309@gmail.com>	<461D46EF.2040805@gmail.com> <20070411140655.6dd2cb3f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:40523 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbXDKVRh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Apr 2007 17:17:37 -0400
Received: by mu-out-0910.google.com with SMTP id g7so377563muf
        for <linux-acpi@vger.kernel.org>; Wed, 11 Apr 2007 14:17:35 -0700 (PDT)
In-Reply-To: <20070411140655.6dd2cb3f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, corentincj@iksaif.net, sziwan@users.sourceforge.net, acpi4asus-user@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org

Andrew Morton napsal(a):
> On Wed, 11 Apr 2007 22:37:03 +0200
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Jiri Slaby napsal(a):
>>> Side note, as Danny wrote, there is an asus-laptop driver sitting in -mm,
>>> which supersedes this one -- if you plan to push it upstream in the near
>>> future, don't bother with this patch.
>> Hmm, there is a 0.40 version in -rc6 yet. There is something weird with me
>> today.
>>
> 
> I don't know what you mean by this.

Oh, 0.40 version, which is in 2.6.21-rc6's drivers/misc/ directory would
"contain" the changes, which are in my patch -- so I thought it's useless,
but the driver is still marked as EXPERIMENTAL, so:

> If your patch is still good then I'd be inclined to proceed with it - yes,
> there's a new driver in Len's tree but I assume we'll be maintaining the
> old one until the new one is proven to be a successful replacement.

as you wrote, we might want the patch for the old one to go through if
nobody has objections.

thanks, sorry for the confusion,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
