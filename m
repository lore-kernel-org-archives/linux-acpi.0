From: jamal <hadi@cyberus.ca>
Subject: Re: Fwd: [PATCH] [-mm] ACPI: export ACPI events via netlink
Date: Fri, 29 Jun 2007 07:48:12 -0400
Message-ID: <1183117692.5156.67.camel@localhost>
References: <1179827251.7707.29.camel@localhost.localdomain>
	 <1179831825.4121.30.camel@localhost>
	 <1180258853.7707.53.camel@localhost.localdomain>
	 <4466a10705270629h31977813hd2fc8330bcd87f78@mail.gmail.com>
	 <4466a10705270634j3560c9a3j9c3630ddc20a24aa@mail.gmail.com>
	 <1181811576.5411.27.camel@localhost.localdomain>
	 <1181820510.4091.9.camel@localhost>
	 <1181869285.5411.39.camel@localhost.localdomain>
	 <1182178882.4063.11.camel@localhost>
	 <1182223964.5411.76.camel@localhost.localdomain>
	 <1182811210.6644.22.camel@johannes.berg>
	 <1182986681.5155.55.camel@localhost>
	 <1183023939.4769.76.camel@johannes.berg>
	 <1183115835.5156.37.camel@localhost>
	 <1183116527.4089.40.camel@johannes.berg>
Reply-To: hadi@cyberus.ca
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:25159 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757015AbXF2LsQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jun 2007 07:48:16 -0400
Received: by wx-out-0506.google.com with SMTP id h31so814565wxd
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jun 2007 04:48:15 -0700 (PDT)
In-Reply-To: <1183116527.4089.40.camel@johannes.berg>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, lenb@kernel.org, Thomas Graf <tgraf@suug.ch>

On Fri, 2007-29-06 at 13:28 +0200, Johannes Berg wrote:
> On Fri, 2007-06-29 at 07:17 -0400, jamal wrote:
> 

> Because of this I'd really prefer if we could hold off on adding groups,
> but I can handle both cases fine by just reserving a family and group ID
> for the current users.
> 

sure - if you rush you can make it into Daves 2.6.23; then both can
conform at the same time.


> I think I'd prefer if we just returned an error. See, we aren't going to
> run out of groups in the foreseeable future, and if we ever have users
> that generate *a lot* of groups we can still add the sharing code etc.
> For now it seems just bloat and a code path we won't ever touch so prone
> to errors in it.
> 

Ok, you are doing the coding and i dont have strong opinions on either;
so go for it.

> Ok :) Though I'm not sure I understood the suggestion of sending just
> one TLV, what should I send? 

I meant when user space asks the controller "please tell me details
about family X" you will always pass an id and name. Never just one.
So why not just send that in a struct which has a id/name (as you
already have defined in your current patch).

cheers,
jamal

