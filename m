From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/6] device property: Introducing software nodes
Date: Wed, 14 Nov 2018 13:45:56 +0100
Message-ID: <CACRpkda+wiiCN+B1FM8Lb8_zR25ehnbY718GYKNuZGePsB+fUg@mail.gmail.com>
References: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 9, 2018 at 3:21 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> This is the second version of my proposal for "software nodes". There
> was a "dereferencing freed memory" bug in patch 3/5 which is now
> fixed. device_add_properties() and device_remove_properties() no
> longer change places in the code as requested by Andy.

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
