From: Ike Panhc <ike.pan@canonical.com>
Subject: Re: [PATCH v2 0/7] ideapad: hotkey enablement
Date: Mon, 13 Dec 2010 16:49:28 +0800
Message-ID: <4D05DE18.3060500@canonical.com>
References: <1291881376-4729-1-git-send-email-ike.pan@canonical.com> <AANLkTimUpXe34tSzvOJ_oo=fyqdAhwkk6xnN10BbdWrH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <AANLkTimUpXe34tSzvOJ_oo=fyqdAhwkk6xnN10BbdWrH@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

On 12/09/2010 04:39 PM, Corentin Chary wrote:
>> acpi_handle is still a global variable becuase we need to pass handle pointer
>> to rfk_set with its opcode but only one data argument available.
> 
> Of course there is only one data argument available, but since it's a
> void *, you
> can use a struct with your handle and the opcode :).
> 

I have tried it. It needs to copy the same handle three times to each struture.
Since we only have an acpi handle, I think to have it global will let driver
easy read.
