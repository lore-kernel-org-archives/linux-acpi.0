From: "Brown, Len" <len.brown@intel.com>
Subject: HZ vs battery life
Date: Wed, 5 Apr 2006 18:03:37 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB61AC6FF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-laptop-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-laptop-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-laptop@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I measured idle battery life at 250HZ, which is what my SL10.1-beta8
laptop has as the default.

I compiled the distro kernel with HZ=1000 and battery life got worse --
no surpose.

But then I built with HZ=100 and it was the same results as HZ=1000,
when I expected it to be better than HZ=250.

clues?
-Len

ps. yes, I'm running at init5.  I'll repeat at init1.
