From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: asus_acpi, support F2JE model
Date: Wed, 11 Apr 2007 22:32:14 +0200
Message-ID: <461D45CE.3030309@gmail.com>
References: <2189310342910921713@karneval.cz> <20070411132053.899462b4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:41773 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965393AbXDKUcP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Apr 2007 16:32:15 -0400
Received: by ug-out-1314.google.com with SMTP id 44so204362uga
        for <linux-acpi@vger.kernel.org>; Wed, 11 Apr 2007 13:32:13 -0700 (PDT)
In-Reply-To: <20070411132053.899462b4.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, corentincj@iksaif.net, sziwan@users.sourceforge.net, acpi4asus-user@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org

Andrew Morton napsal(a):
> On Wed, 11 Apr 2007 15:04:35 +0200 (CEST)
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> @@ -706,6 +718,8 @@ static int get_lcd_state(void)
>>  {
>>  	int lcd = 0;
>>  
>> +	BUG_ON(!hotk->methods->lcd_status);
> 
> mutter.  We could just warn-and-bale here.
> 
> Hopefully this is just an is-jiri-sane assertion and it should never happen,
> no matter how busted the BIOS tables are?

Exactly :). Only if somebody changes the code around, so that it is called
with the method unset, it triggers and in that case it's definitely a bug.

Side note, as Danny wrote, there is an asus-laptop driver sitting in -mm,
which supersedes this one -- if you plan to push it upstream in the near
future, don't bother with this patch.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
