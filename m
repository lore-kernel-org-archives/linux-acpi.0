From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 01/24] Documentation: add Linux ACPI to Sphinx TOC tree
Date: Sat, 30 Mar 2019 10:51:50 +0100
Message-ID: <CAJZ5v0h=tpzWJrt02ET28EG9hn6eSusLV68FZCV8nnXHDBxHEQ@mail.gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com> <20190329001135.15847-2-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329001135.15847-2-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 29, 2019 at 1:12 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Add a index.rst for trace subsystem. More docs will be added later.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/acpi/index.rst | 8 ++++++++
>  Documentation/index.rst      | 1 +
>  2 files changed, 9 insertions(+)
>  create mode 100644 Documentation/acpi/index.rst
>
> diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
> new file mode 100644
> index 000000000000..7241ceb1673c
> --- /dev/null
> +++ b/Documentation/acpi/index.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================================
> +Linux ACPI (Advanced Configuration and Power Interface)

"Linux ACPI Support", please.

> +=======================================================
> +
> +.. toctree::
> +   :maxdepth: 2
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 80a421cb935e..e3aa28275894 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -90,6 +90,7 @@ needed).
>     filesystems/index
>     vm/index
>     bpf/index
> +   acpi/index
>     misc-devices/index
>
>  Architecture-specific documentation
> --
> 2.20.1
>
