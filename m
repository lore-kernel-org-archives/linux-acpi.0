From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V7 02/11] PNPACPI: use whilte list for pnpacpi device enumeration
Date: Thu, 22 May 2014 12:14:44 -0600
Message-ID: <CAErSpo7PjPf8AK1ectzE1Ep-AQKSXHY8TfZatrOC8ZzbAcxjow@mail.gmail.com>
References: <1400781753-2682-1-git-send-email-rui.zhang@intel.com> <1400781753-2682-3-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400781753-2682-3-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

"white" is misspelled in the subject line.  I mentioned this before.

On Thu, May 22, 2014 at 12:02 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> ACPI can be used to enumerate PNP devices, but the code does not
> handle this in a good manner.
> ...
