From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI, APEI, Fix use resource_size
Date: Sat, 16 Dec 2017 12:56:15 +0100
Message-ID: <20171216115615.j5uncek3iiigwkl7@pd.tnic>
References: <1513007072-32020-1-git-send-email-gomonovych@gmail.com>
 <4222319.ltJQ6b6Cov@aspire.rjw.lan>
 <20171213153857.2cftlirw7vbo5orm@pd.tnic>
 <CAJZ5v0h5AMJkQFm3uHX+DS=tSeYgYq+6=h0b-WP8Y+McSTLc3w@mail.gmail.com>
 <20171214093759.n63hrae6yyug4aml@pd.tnic>
 <CAJZ5v0jsV3Przvn5LfchbiBQU3HK9G+hW9iOb4cHhzvbiWKPzA@mail.gmail.com>
 <CAJZ5v0hA9QdAc1_Gwtu+hBGiH8nn84TS0Bwx0Ln4by6UpKDpSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hA9QdAc1_Gwtu+hBGiH8nn84TS0Bwx0Ln4by6UpKDpSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vasyl Gomonovych <gomonovych@gmail.com>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 16, 2017 at 11:43:27AM +0100, Rafael J. Wysocki wrote:
> The argument of resource_size() is (const struct resource *) and res
> is of type (struct apei_res *).
> 
> I'm dropping this one.

Yeah, us reviewing this one was one big FAIL.

And I tell myself everytime - build those patches first! Srsly! People
really don't even build-test their shit before submitting. Because look
at the compiler output - it is everything but quiet. Crap didn't even
build.

Geez.

In file included from ./include/linux/acpi.h:25:0,
                 from drivers/acpi/apei/apei-base.c:32:
drivers/acpi/apei/apei-base.c: In function ‘apei_resources_request’:
drivers/acpi/apei/apei-base.c:509:52: error: passing argument 1 of ‘resource_size’ from incompatible pointer type [-Werror=incompatible-pointer-type]
   r = request_mem_region(res->start, resource_size(res), desc);
                                                    ^
./include/linux/ioport.h:223:86: note: in definition of macro ‘request_mem_region’
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name), 0)
                                                                                      ^
./include/linux/ioport.h:196:31: note: expected ‘const struct resource *’ but argument is of type ‘struct apei_res *’
 static inline resource_size_t resource_size(const struct resource *res)
                               ^~~~~~~~~~~~~
drivers/acpi/apei/apei-base.c:521:48: error: passing argument 1 of ‘resource_size’ from incompatible pointer type [-Werror=incompatible-pointer-type]
   r = request_region(res->start, resource_size(res), desc);
                                                ^
./include/linux/ioport.h:220:84: note: in definition of macro ‘request_region’
 #define request_region(start,n,name)  __request_region(&ioport_resource, (start), (n), (name), 0)
                                                                                    ^
./include/linux/ioport.h:196:31: note: expected ‘const struct resource *’ but argument is of type ‘struct apei_res *’
 static inline resource_size_t resource_size(const struct resource *res)
                               ^~~~~~~~~~~~~
drivers/acpi/apei/apei-base.c:544:44: error: passing argument 1 of ‘resource_size’ from incompatible pointer type [-Werror=incompatible-pointer-type]
   release_region(res->start, resource_size(res));
                                            ^
./include/linux/ioport.h:234:78: note: in definition of macro ‘release_region’
 #define release_region(start,n) __release_region(&ioport_resource, (start), (n))
                                                                              ^
./include/linux/ioport.h:196:31: note: expected ‘const struct resource *’ but argument is of type ‘struct apei_res *’
 static inline resource_size_t resource_size(const struct resource *res)
                               ^~~~~~~~~~~~~
drivers/acpi/apei/apei-base.c:551:48: error: passing argument 1 of ‘resource_size’ from incompatible pointer type [-Werror=incompatible-pointer-type]
   release_mem_region(res->start, resource_size(res));
                                                ^
./include/linux/ioport.h:235:81: note: in definition of macro ‘release_mem_region’
 #define release_mem_region(start,n) __release_region(&iomem_resource, (start), (n))
                                                                                 ^
./include/linux/ioport.h:196:31: note: expected ‘const struct resource *’ but argument is of type ‘struct apei_res *’
 static inline resource_size_t resource_size(const struct resource *res)
                               ^~~~~~~~~~~~~
drivers/acpi/apei/apei-base.c: In function ‘apei_resources_release’:
drivers/acpi/apei/apei-base.c:568:48: error: passing argument 1 of ‘resource_size’ from incompatible pointer type [-Werror=incompatible-pointer-type]
   release_mem_region(res->start, resource_size(res));
                                                ^
./include/linux/ioport.h:235:81: note: in definition of macro ‘release_mem_region’
 #define release_mem_region(start,n) __release_region(&iomem_resource, (start), (n))
                                                                                 ^
./include/linux/ioport.h:196:31: note: expected ‘const struct resource *’ but argument is of type ‘struct apei_res *’
 static inline resource_size_t resource_size(const struct resource *res)
                               ^~~~~~~~~~~~~
drivers/acpi/apei/apei-base.c:570:44: error: passing argument 1 of ‘resource_size’ from incompatible pointer type [-Werror=incompatible-pointer-type]
   release_region(res->start, resource_size(res));
                                            ^
./include/linux/ioport.h:234:78: note: in definition of macro ‘release_region’
 #define release_region(start,n) __release_region(&ioport_resource, (start), (n))
                                                                              ^
./include/linux/ioport.h:196:31: note: expected ‘const struct resource *’ but argument is of type ‘struct apei_res *’
 static inline resource_size_t resource_size(const struct resource *res)
                               ^~~~~~~~~~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:310: recipe for target 'drivers/acpi/apei/apei-base.o' failed
make[1]: *** [drivers/acpi/apei/apei-base.o] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1674: recipe for target 'drivers/acpi/apei/' failed
make: *** [drivers/acpi/apei/] Error 2

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
