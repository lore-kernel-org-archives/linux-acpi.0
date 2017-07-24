From: Boris Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 20:50:30 +0300
Message-ID: <9152D80E-386A-4B7D-8B37-D87748675BF9@alien8.de>
References: <1500654661.2042.49.camel@hpe.com> <20170721140131.40079805@vento.lan> <20170721172344.GA11316@nazgul.tnic> <1500661773.2042.53.camel@hpe.com> <20170722062853.GA2050@nazgul.tnic> <1500907209.2042.55.camel@hpe.com> <20170724150432.GA31295@nazgul.tnic> <1500909372.2042.58.camel@hpe.com> <20170724153716.GA17708@nazgul.tnic> <1500911226.2042.60.camel@hpe.com> <20170724163754.GA18184@nazgul.tnic> <1500917682.2042.62.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:36116 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754118AbdGXRuf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 13:50:35 -0400
In-Reply-To: <1500917682.2042.62.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On July 24, 2017 8:44:03 PM GMT+03:00, "Kani, Toshimitsu" <toshi.kani@hpe.com> wrote:
>I assumed our platforms w/o build-in RAS do not implement GHES,

If we make it a normal module, it will be decoupled from GHES and it will rely only on the whitelist to load. 
-- 
Sent from a small device: formatting sux and brevity is inevitable. 
