From: jamal <hadi@cyberus.ca>
Subject: Re: Fwd: [PATCH] [-mm] ACPI: export ACPI events via netlink
Date: Fri, 29 Jun 2007 09:02:52 -0400
Message-ID: <1183122172.5188.24.camel@localhost>
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
	 <1183023939.4769.76.camel@johannes.berg>  <4684F25B.5090607@trash.net>
	 <1183121180.4089.51.camel@johannes.berg>  <4684FF9A.10807@trash.net>
Reply-To: hadi@cyberus.ca
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4684FF9A.10807@trash.net>
Sender: netdev-owner@vger.kernel.org
To: Patrick McHardy <kaber@trash.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, lenb@kernel.org, Thomas Graf <tgraf@suug.ch>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2007-29-06 at 14:48 +0200, Patrick McHardy wrote:
> Johannes Berg wrote:

> > Hmm, another thought: since we have 32 bits for group numbers and 16
> > bits for families we could just reserve 16 bits for groups within each
> > family. Or do we get trouble with that because in some place there's a
> > group bitmap or such?
> 
> 
> Yes, af_netlink has a bitmap per socket that is subscribed to any group.


I think this is the challenge. The groups belong to a global namespace.
i.e when you do a socket bind to group - it is unique regardless of the
family.
Our philosophy in genetlink is to have dynamic resources allocated and
released - remember the real reason we even have this is because we were
running out of numbers ;->
So while the static allocation of 16 bits per group will work (famous
last words "noone will ever need more than 640K of RAM";->) it will be
cleaner imo to allow dynamic allocation/release.
Maybe a mix (of a few static and mostly dynamic) as Patrick says - but
that would mean more coding for you ;-> Actually i like the idea of at
least your ID being your static mcast group and the rest are in the
dynamic pool (Hey, thanks Patrick;->). This means the first 2^16 are
static/reserved and if you want more groups, you register for them.

cheers,
jamal

