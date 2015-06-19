From: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>
Subject: RE: [PATCH 00/22] FUJITSU Extended Socket network device driver
Date: Fri, 19 Jun 2015 04:20:49 +0000
Message-ID: <E86EADE93E2D054CBCD4E708C38D364A5424255E@G01JPEXMBYT01>
References: <1434588359-25589-1-git-send-email-izumi.taku@jp.fujitsu.com>
 <20150618212210.GA121898@vmdeb7>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20150618212210.GA121898@vmdeb7>
Content-Language: ja-JP
Sender: netdev-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Joe Perches <joe@perches.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rkhan@redhat.com" <rkhan@redhat.com>, "alexander.h.duyck@redhat.com" <alexander.h.duyck@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


 Thank you for reviewing.

> As Alex mentioned earlier, I suspect this is more appropriate for drivers/net.
> If David objects, we can consider for platform/drivers/x86.

 OK, I'll migrate the code from drivers/platform/x86 to drivers/net and also
 incorporate comments. I'm going to resend one soon.

 Sincerely,
 Taku Izumi
