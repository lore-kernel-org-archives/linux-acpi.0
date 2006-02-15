From: Renato Golin <rengolin@gmail.com>
Subject: Re: Toshiba Equium L20
Date: Wed, 15 Feb 2006 13:36:45 +0000
Message-ID: <d9b9d95f0602150536y49e9534bu6a7e18cad686e5ab@mail.gmail.com>
References: <1140001153.8856.1.camel@localhost>
	 <d9b9d95f0602150520j72e0e89ai883f1118cd662c65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:55703 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945938AbWBONgt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Feb 2006 08:36:49 -0500
Received: by wproxy.gmail.com with SMTP id 36so112376wra
        for <linux-acpi@vger.kernel.org>; Wed, 15 Feb 2006 05:36:48 -0800 (PST)
In-Reply-To: <d9b9d95f0602150520j72e0e89ai883f1118cd662c65@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Sorry for the spam again, but the kernel 2.6.15.4 have some
differences on the methods I saw.

On parser/psparse.c, function acpi_ps_parse_aml:

status = acpi_ds_call_control_method(thread, walk_state, NULL);
(...)
} else if ((status != AE_OK) && (walk_state->method_desc)) {
  ACPI_REPORT_METHOD_ERROR("Method execution failed",
walk_state->method_node, NULL, status);


On dispatcher/dsmethod.c, function acpi_ds_call_control_method

still no AE_NOT_FOUND ...

Btw, I'm going to post now on my site my dmesgs/lspci/ifconfig for
kernel 2.6.15 with and without acpi.

cheers,
--rengolin
