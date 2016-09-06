From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI-APEI-HEST: Fine-tuning for three function implementations
Date: Tue, 6 Sep 2016 13:25:03 +0200
Message-ID: <CAJZ5v0i5EW1UpLfaogyD-s4P4vXdgWndwjOpF5ykPDXE=eZVSA@mail.gmail.com>
References: <566ABCD9.1060404@users.sourceforge.net> <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
 <CAJZ5v0hcD8pi8y+jAtF70cJp8uYyUdOeDJKuR3z=JpB6Z_Qnfw@mail.gmail.com> <06ab72bc-6e00-1829-f1bf-67f0a31aff38@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <06ab72bc-6e00-1829-f1bf-67f0a31aff38@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 6, 2016 at 5:38 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> Like in the other patch series I've just commented,
>
> Thanks for your quick response.
>
>
>> please put all label renames into one patch.
>
> Could you accept these update suggestions generally?
>
>
> I would prefer to avoid squashing special changes together by default.

Well, as I said elsewhere, if you make the same type of change in
multiple places in one piece of code (or code maintained by the same
maintainer), you make it easier to review those changes if they go in
one patch.

Thanks,
Rafael
