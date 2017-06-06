From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Tue, 6 Jun 2017 12:04:40 +0200
Message-ID: <20170606100440.GA4690@pali>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35182 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbdFFKEr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2017 06:04:47 -0400
Content-Disposition: inline
In-Reply-To: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday 05 June 2017 20:16:44 Andy Lutomirski wrote:
> +#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
> +MODULE_ALIAS("wmi:" WMI_BMOF_GUID);

Cannot we generate MODULE_ALIAS from module_wmi_driver()? IIRC it is
working for i2c drivers.

-- 
Pali Rohár
pali.rohar@gmail.com
