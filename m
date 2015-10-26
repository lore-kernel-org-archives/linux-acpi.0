From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 04/22] of: add function to allow probing a device from a OF node
Date: Mon, 26 Oct 2015 09:15:47 +0900
Message-ID: <31FFF416-BB40-4DC5-8CAF-8EF106FDD373@gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com> <10119606.2TraDKGPVy@vostro.rjw.lan> <CAAObsKCAX4DQGydQoYjJEYKTOEqpVozXdHnqXWdNYVkLsg7BVg@mail.gmail.com> <8510008.IC14Fu2Aos@vostro.rjw.lan> <562BE562.8090704@kernel.org> <20151026001301.GT29919@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35112 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbJZAQA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Oct 2015 20:16:00 -0400
In-Reply-To: <20151026001301.GT29919@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On October 26, 2015 9:13:01 AM GMT+09:00, Mark Brown <broonie@kernel.org> wrote:
>On Sat, Oct 24, 2015 at 03:09:06PM -0500, Rob Herring wrote:
>
>> Let's get agreement on the flow and structure and how to address
>other
>> issues like suspend, then we can worry about whether this needs to be
>> abstracted from subsystems. We can discuss more this week at KS.
>
>Should we try to schedule an ad-hoc session today (Monday) for those of
>us who are here to talk this over?


That would be great.

Thanks.

-- 
Dmitry
