From: Lu Tong <ltong-r3+FECOBLOPAaqN1iTbosg@public.gmane.org>
Subject: problem with the management of address handlers
Date: Fri, 14 Mar 2003 00:36:12 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030314053612.GA6936@dao.cs.ohiou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--- ok, first we had

evregion-0320 [36] ev_address_space_dispa: Addrhandler e7df4da8 (c019be90), Address 0000000027F7BF14

--- where e7df4da8 is a handler for system memory. then, it found the EC device, it ran  (in ec.c)

  if (ec_ecdt && ec_ecdt->uid == uid) {
      acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
                ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);

      acpi_remove_gpe_handler(ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);

      kfree(ec_ecdt);
  }

--- to remove two handlers, and the debug output is 

evxfregn-0369 [25] acpi_remove_address_sp: Removing address handler e7df4f28(c01b75b0) for region EmbeddedControl on Device c02cfd1c(e7df4d48)
evregion-0420 [26] ev_detach_region      : Removing Region e7e72448 from address handler e7df4f28

--- then, we had 

ACPI: Embedded Controller [EC] (gpe 28)
evxfregn-0200 [25] acpi_install_address_s: Creating object on Device e7e70c28 while installing handler
evxfregn-0232 [25] acpi_install_address_s: Installing address handler for region EmbeddedControl(3) on Device EC__ e7e70c28(e7df4f28)
evxfregn-0258 [25] acpi_install_address_s: new addr handler e7df4da8, next_handler 00000000
                Type : addr_handler
     Reference Count : 1
               Flags : 0
            space_id : 3
                Next : 00000000
         region_list : 00000000
                Node : e7e70c28
             Context : e7de86e0
evregion-0533 [27] ev_attach_region      : Adding Region e7e72448 to address handler e7df4da8 [EmbeddedControl]
evregion-0320 [39] ev_address_space_dispa: Addrhandler e7df4da8 (c01b75b0), Address 0000000000000038

--- now, we have some problem. the new addr handler for EC region is also e7df4da8, but the handler function was changed to acpi_ec_space_handler(). my guess is that addr_handler e7df4da8 was deleted and returned to cache_list before installing address handler for EC region. after commenting out the if block that checks UID of EC, the problems went way. i know it's a bad fix. so can someone over there fix the problem?

--ltong



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
